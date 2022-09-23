<template>
  <div class="main_container">
    <div class="tab_container">
      <div class="operation">
        <el-button size="medium" type="primary" @click="showIpDiglog()">新增黑名单</el-button>
        <el-input class="search_input" size="medium" v-model="search" placeholder="输入ip" @input="searchTableData()"
          suffix-icon="el-icon-search">
        </el-input>
      </div>
      <el-table :data="tableData" :height="tabH" default-expand-all row-key="id">
        <el-table-column label="ip">
          <template slot-scope="scope"><span>{{scope.row.ip}}</span></template>
        </el-table-column>
        <el-table-column label="地址">
          <template slot-scope="scope"><span>{{scope.row.mapping}}</span></template>
        </el-table-column>
        <el-table-column label="开始时间">
          <template slot-scope="scope"><span>{{scope.row.createTime}}</span></template>
        </el-table-column>
        <el-table-column label="封禁时长">
          <template slot-scope="scope">
            <span>{{scope.row.effectiveTime=='-1'?'永久':scope.row.effectiveTime+"小时"}}</span>
          </template>
        </el-table-column>
        <el-table-column label="结束时间">
          <template
            slot-scope="scope"><span>{{showSurplusTime(scope.row.createTime,scope.row.effectiveTime)}}</span></template>
        </el-table-column>
        <el-table-column label="是否启用">
          <template slot-scope="scope">
            <el-switch :value="scope.row.type" active-color="#13ce66" inactive-color="#ff4949" active-value="1"
              inactive-value="0">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="备注">
          <template slot-scope="scope"><span>{{scope.row.remarks}}</span></template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <!-- <el-button size="mini" type="primary" @click="getMenusInfo(scope.row)">编辑</el-button> -->
            <el-button size="mini" type="danger" @click=" deleteBackIpInfo(scope.row.id)">删除</el-button>
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
      <el-dialog :title="title" :visible.sync="dialog" width="30%" center @close="clearFormData()">
        <el-form :model="form" :rules="rules" ref="form" :inline="true" label-width="140px">

          <el-form-item label="ip" prop="ip">
            <el-input v-model="form.ip" placeholder="请输入封禁的ip地址 例(0.0.0.0)"></el-input>
          </el-form-item>
          <!-- <el-form-item label="地址" prop="mapping">
            <el-input v-model="form.mapping" placeholder="请输入地址 例:(/xxxxx),所有则(*)"></el-input>
          </el-form-item> -->
          <el-form-item label="封禁时间" prop="effectiveTime">
            <el-input v-model="form.effectiveTime" placeholder="请输入封禁时间,单位小时(-1永久)"></el-input>
          </el-form-item>
          <el-form-item label="是否启用" prop="type">
            <el-switch v-model="form.type" active-color="#13ce66" inactive-color="#ff4949" active-value="1"
              inactive-value="0">
            </el-switch>
          </el-form-item>
        </el-form>
        <div class="dialog_button">
          <el-button size="medium" type="primary" @click="submitForm('form')">确 定</el-button>
          <el-button size="medium" type="primary" @click="clearFormData()">取 消</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { backIpListByPage, addBackIp, deleteBackIp } from "@/api/httpApi";
import { pageObj, autoPageObjFun, dateFormat } from "@/api/staticType";
export default {
  name: 'backIp',
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
      search: "",
      title: "",
      form: {
        type: "0"
      },
      options: [],
      value: '',
      rules: {
        ip: [
          { required: true, message: '请选择封禁ip', trigger: 'blur' },
        ],
        mapping: [
          { required: true, message: '请输入地址', trigger: 'blur' },
        ],
        effectiveTime: [
          { required: true, message: '请输入封禁时间', trigger: 'blur' },
        ],
      },
      id: null
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
    this.listByPage();
  },
  methods: {
    async deleteBackIpInfo (id) {
      let ids = [];
      ids.push(id);
      let result = await deleteBackIp(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.$message.success("删除成功");
      this.listByPage();
    },
    submitForm (formName) {
      let id = this.id;
      let ip = this.form.ip;
      let mapping = this.form.mapping;
      let effectiveTime = this.form.effectiveTime;
      let type = this.form.type;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (id == null) {
            this.addBackIpInfo(ip, mapping, effectiveTime, type);
          } else {

          }
        } else {
          return false;
        }
      });
    },
    async addBackIpInfo (ip, mapping, effectiveTime, type) {
      let { data } = await addBackIp(ip, mapping, effectiveTime, type);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    showIpDiglog () {
      this.title = '添加黑名单Ip'
      this.dialog = true;
    },
    async listByPage () {
      let result = await backIpListByPage(this.page.page, this.page.limit, this.search).then((data) => {
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
    async pageFun (page) {
      let result = await backIpListByPage(page, this.page.limit, this.search).then((data) => {
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
    searchTableData () {
      this.listByPage();
    },
    clearFormData () {
      this.$refs['form'].resetFields();
      this.form = {
        type: "0"
      };
      this.id = null;
      this.dialog = false;
      this.listByPage();
    },
    showSurplusTime (startTime, time) {
      if (time == "-1") {
        return "-";
      }


      var t = new Date(new Date(startTime).getTime() + time * 3600 * 1000);

      return dateFormat("YYYY-mm-dd HH:MM:SS", t);

    }
  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>