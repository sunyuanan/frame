<template>
  <div class="main_container">
    <div class="tab_container">
      <div class="operation">
        <el-button size="medium" type="primary" @click="showRegionDiglog()">新增白名单地区</el-button>
        <el-input class="search_input" size="medium" v-model="search" placeholder="输入城市名" @input="searchTableData()"
          suffix-icon="el-icon-search">
        </el-input>
      </div>
      <el-table :data="tableData" :height="tabH" default-expand-all row-key="id">
        <el-table-column label="省名">
          <template slot-scope="scope"><span>{{scope.row.region}}</span></template>
        </el-table-column>
        <el-table-column label="城市名">
          <template slot-scope="scope"><span>{{scope.row.city}}</span></template>
        </el-table-column>
        <el-table-column label="创建时间">
          <template slot-scope="scope"><span>{{scope.row.createTime}}</span></template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="danger" @click=" deleteRegionInfo(scope.row.id)">删除</el-button>
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

          <el-form-item label="省" prop="region">
            <el-input v-model="form.region" placeholder="请输入省名"></el-input>
          </el-form-item>
          <el-form-item label="城市" prop="city">
            <el-input v-model="form.city" placeholder="请输入城市名"></el-input>
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
import { whiteRegionByPage, addWhiteRegion, deleteRegion } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";
export default {
  name: 'whiteRegion',
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
      form: {},
      rules: {
        region: [
          { required: true, message: '请输入省名', trigger: 'blur' },
        ],
        city: [
          { required: true, message: '请输入城市名', trigger: 'blur' },
        ]
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
    this.listByPage();
  },
  methods: {
    async deleteRegionInfo (id) {
      let ids = [];
      ids.push(id);
      let result = await deleteRegion(ids).then((data) => {
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
      let city = this.form.city;
      let region = this.form.region;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.addWhiteRegionInfo(city, region);
        } else {
          return false;
        }
      });
    },
    async addWhiteRegionInfo (city, region) {
      let { data } = await addWhiteRegion(city, region);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    showRegionDiglog () {
      this.title = '新增地区白名单'
      this.dialog = true;
    },
    async listByPage () {
      let result = await whiteRegionByPage(this.page.page, this.page.limit, this.search).then((data) => {
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
      let result = await whiteRegionByPage(page, this.page.limit, this.search).then((data) => {
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
      this.form = {};
      this.dialog = false;
      this.listByPage();
    },
  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>