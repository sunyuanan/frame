<template>
  <div class="main_container">
    <div class="tab_container">
      <div class="operation">
        <el-button type="primary" @click="showDialog()">添加任务</el-button>
      </div>
      <el-table :data="tableData" :height="tabH">
        <el-table-column label="描述">
          <template slot-scope="scope"><span>{{scope.row.remark}}</span></template>
        </el-table-column>
        <el-table-column label="任务名称">
          <template slot-scope="scope"><span>{{scope.row.jobName}}</span></template>
        </el-table-column>
        <el-table-column label="任务分组">
          <template slot-scope="scope"><span>{{scope.row.jobGroup}}</span></template>
        </el-table-column>
        <el-table-column label="执行方法">
          <template slot-scope="scope"><span>{{scope.row.methodName}}</span></template>
        </el-table-column>
        <el-table-column label="方法参数">
          <template slot-scope="scope"><span>{{scope.row.methodParams}}</span></template>
        </el-table-column>
        <el-table-column label="执行表达式">
          <template slot-scope="scope"><span>{{scope.row.cronExpression}}</span></template>
        </el-table-column>
        <el-table-column label="状态">
          <template slot-scope="scope"><span>
              <el-switch :value="scope.row.status == 0?true:false" active-color="#13ce66" inactive-color="#ff4949"
                disabled>
              </el-switch>
            </span></template>
        </el-table-column>
        <el-table-column label="操作" width="360">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" @click=" showEditJobDialog(scope.row)">编辑</el-button>
            <el-button size="mini" type="success" @click=" triggerTask(scope.row.id)">执行</el-button>
            <el-button size="mini" type="danger" @click=" pauseTask(scope.row.id)">停止</el-button>
            <el-button size="mini" type="danger" @click=" resumeTask(scope.row.id)">恢复</el-button>
            <el-button size="mini" type="danger" @click=" deleteTask(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="page">

        <el-pagination background @current-change="pageFun" :current-page.sync="page.page" :page-size="page.limit"
          layout="total, prev, pager, next, jumper" :total="page.total">
        </el-pagination>

      </div>
    </div>
    <div class="dialog_container">
      <el-dialog :title="title" :visible.sync="dialog" width="50%" center @close="clearFormData()">
        <el-form :model="form" :rules="rules" ref="form" :inline="true" label-width="120px">
          <el-form-item label="描述" prop="remark">
            <el-input v-model="form.remark" placeholder="请输入描述"></el-input>
          </el-form-item>
          <el-form-item label="执行类" prop="jobName">
            <el-input v-model="form.jobName" placeholder="请输入执行类"></el-input>
          </el-form-item>
          <el-form-item label="任务分组" prop="jobGroup">
            <el-input v-model="form.jobGroup" placeholder="请输入任务分组"></el-input>
          </el-form-item>
          <el-form-item label="执行方法" prop="methodName">
            <el-input v-model="form.methodName" placeholder="请输入执行方法"></el-input>
          </el-form-item>
          <el-form-item label="执行参数">
            <el-input v-model="form.methodParams" placeholder="请输入执行参数"></el-input>
          </el-form-item>
          <el-form-item label="执行表达式" prop="cronExpression">
            <el-input v-model="form.cronExpression" placeholder="请输入执行表达式"></el-input>
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-switch v-model="form.status" active-color="#13ce66" inactive-color="#ff4949" active-value="0"
              inactive-value="1">
            </el-switch>
          </el-form-item>
        </el-form>
        <div class="dialog_button">
          <el-button type="primary" @click="submitForm('form')">确 定</el-button>
          <el-button type="primary" @click="clearFormData()">取 消</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { jobListByPage, triggerTask, pauseTask, resumeTask, deleteTask, addJob, editJob } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";
export default {
  name: 'Job',
  data () {
    return {
      tableData: [],
      tabH: 0,
      page: {
        total: 0,
        limit: 0,
        page: pageObj.currentPage,
      },
      dialog: false,
      title: "",
      form: {
        status: "0"
      },
      rules: {
        remark: [
          { required: true, message: '请输入描述', trigger: 'blur' },
        ],
        jobName: [
          { required: true, message: '请输入执行类', trigger: 'blur' },
        ],
        jobGroup: [
          { required: true, message: '请输入任务分组', trigger: 'blur' },
        ],
        methodName: [
          { required: true, message: '请输入执行方法', trigger: 'blur' },
        ],
        cronExpression: [
          { required: true, message: '请输入执行表达式', trigger: 'blur' },
        ],
      },
      jobId: null
    }
  },
  //生命周期 - 创建完成（访问当前this实例）
  created () {
    let obj = autoPageObjFun();
    this.tabH = obj.tabH;
    this.page.limit = obj.tabNum;
  },
  //生命周期 - 挂载完成（访问DOM元素）
  mounted () {
    this.jobListByPage();
  },
  methods: {
    showEditJobDialog (row) {
      this.jobId = row.id
      this.form = row
      this.dialog = true;
      this.title = '编辑任务调度'
    },
    clearFormData () {
      // 清空表单信息
      this.$refs['form'].resetFields();
      this.form = { status: "0" };
      this.dialog = false;
      this.jobListByPage();

    },
    submitForm (formName) {
      let jobId = this.jobId;
      let jobName = this.form.jobName;
      let jobGroup = this.form.jobGroup;
      let methodName = this.form.methodName;
      let cronExpression = this.form.cronExpression;
      let status = this.form.status;
      let remark = this.form.remark;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (jobId == null) {
            this.addJobInfo(jobName, jobGroup, methodName, cronExpression, status, remark);
          } else {
            this.editJobInfo(jobId, jobName, jobGroup, methodName, cronExpression, status, remark);
          }
        } else {
          return false;
        }
      })
    },
    async addJobInfo (jobName, jobGroup, methodName, cronExpression, status, remark) {

      let { data } = await addJob(jobName, jobGroup, methodName, cronExpression, status, remark);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async editJobInfo (jobId, jobName, jobGroup, methodName, cronExpression, status, remark) {
      let { data } = await editJob(jobId, jobName, jobGroup, methodName, cronExpression, status, remark);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    showDialog () {
      this.title = "新增任务调度"
      this.dialog = true;
    },
    async jobListByPage () {
      let result = await jobListByPage(this.page.page, this.page.limitsearch).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          console.log(response)
          return this.$message.error(response.msg);
        }
      });
      this.tableData = result.records;
      this.page.total = result.total;
    },
    async pageFun (page) {
      let result = await jobListByPage(page, this.page.limit).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.tableData = result.records;
      this.page.total = result.total;
    },
    async triggerTask (id) {
      let ids = [];
      ids.push(id);
      let result = await triggerTask(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.$message.success("执行成功");
      this.jobListByPage();
    },
    async pauseTask (id) {
      let ids = [];
      ids.push(id);
      let result = await pauseTask(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.$message.success("已停止任务");
      this.jobListByPage();
    },
    async resumeTask (id) {
      let ids = [];
      ids.push(id);
      let result = await resumeTask(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.$message.success("已恢复任务");
      this.jobListByPage();
    },
    async deleteTask (id) {
      let ids = [];
      ids.push(id);
      let result = await deleteTask(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.$message.success("删除成功");
      this.jobListByPage();
    }
  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>