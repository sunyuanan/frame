<template>
  <div class="main_container">

    <div class="tab_container">
      <div class="operation">
        <el-button type="danger" size="medium" @click="deleteLogs()">批量删除</el-button>
        <el-input class="search_input" v-model="search" placeholder="输入用户操作" @input="searchTableData()"
          suffix-icon="el-icon-search">
        </el-input>
      </div>
      <el-table :data="tableData" :height="tabH" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55">
        </el-table-column>
        <el-table-column label="拦截ip" width="150px">
          <template slot-scope="scope"><span>{{scope.row.ip}}</span></template>
        </el-table-column>
        <el-table-column label="拦截内容" width="200px" :show-overflow-tooltip="true">
          <template slot-scope="scope"><span>{{scope.row.errorInfo}}</span></template>
        </el-table-column>
        <el-table-column label="接口地址" :show-overflow-tooltip="true">
          <template slot-scope="scope"><span>{{scope.row.requestUrl}}</span></template>
        </el-table-column>
        <el-table-column label="请求方法" width="100px">
          <template slot-scope="scope"><span>{{scope.row.method}}</span></template>
        </el-table-column>
        <el-table-column label="请求参数" :show-overflow-tooltip="true">
          <template slot-scope="scope"><span>{{scope.row.params}}</span></template>
        </el-table-column>
        <el-table-column label="创建时间" width="200px">
          <template slot-scope="scope"><span>{{scope.row.createTime}}</span></template>
        </el-table-column>
        <el-table-column label="操作" width="160px">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" @click="showIpDiglog(scope.row.ip)">封禁ip</el-button>
            <el-button size="mini" type="danger" @click="deleteLog(scope.row.id)">删除</el-button>
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
          <el-form-item label="封禁时间" prop="effectiveTime">
            <el-input v-model="form.effectiveTime" placeholder="请输入封禁时间,单位小时(-1永久)"></el-input>
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

import { listSysInterceptLogPage, deleteSysInterceptLogs, addBackIp } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";

export default {
  name: 'SysErrorLog',
  data () {
    return {
      tableData: [],
      tabH: 0,
      search: "",
      page: {
        total: 0,
        limit: 0,
        page: pageObj.currentPage,
      },
      multipleSelection: [],
      selectedIDs: [],

      dialog: false,
      title: "",
      form: {},
      rules: {
        effectiveTime: [
          { required: true, message: '请输入封禁时间', trigger: 'blur' },
        ],
      },
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
    this.listSysInterceptLogByPage();
  },
  methods: {

    showIpDiglog (ip) {
      this.form.ip = ip;
      this.title = "封禁ip";
      this.dialog = true;
    },
    submitForm (formName) {
      let ip = this.form.ip;
      let effectiveTime = this.form.effectiveTime;
      let type = 1
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.addBackIpInfo(ip, "", effectiveTime, type);
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
    clearFormData () {
      this.$refs['form'].resetFields();
      this.form = {};
      this.id = null;
      this.dialog = false;
    },



    handleSelectionChange (val) {

      this.multipleSelection = val;
      let ids = []
      this.multipleSelection.map((item) => {
        ids.push(item.id)
      })
      this.selectedIDs = ids
    },
    async deleteLog (id) {
      let ids = [];
      ids.push(id)
      let result = await deleteSysInterceptLogs(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          this.listSysInterceptLogByPage();
          return this.$message.success("删除成功");
        } else {
          return this.$message.error(response.msg);
        }
      });
    },
    async deleteLogs () {
      let result = await deleteSysInterceptLogs(this.selectedIDs).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          this.listSysInterceptLogByPage();
          return this.$message.success("删除成功");
        } else {
          return this.$message.error(response.msg);
        }
      });
    },
    async listSysInterceptLogByPage () {
      let result = await listSysInterceptLogPage(this.page.page, this.page.limit, this.search).then((data) => {
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
      let result = await listSysInterceptLogPage(page, this.page.limit, this.search).then((data) => {
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
      this.listSysInterceptLogByPage();
    }
  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>