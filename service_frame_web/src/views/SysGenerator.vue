<template>
  <div class="main_container">
    <div class="tab_container">
      <div class="operation">
        <el-input class="search_input" size="medium" v-model="search" placeholder="输入表名/表备注" @input="searchTableData()"
          suffix-icon="el-icon-search">
        </el-input>
      </div>
      <el-table :data="tableData" :height="tabH">
        <el-table-column label="是否生成">
          <template slot-scope="scope"><span>{{scope.row.id==null?"否":"是"}}</span></template>
        </el-table-column>
        <el-table-column label="表名">
          <template slot-scope="scope"><span>{{scope.row.tableName}}</span></template>
        </el-table-column>
        <el-table-column label="表备注">
          <template slot-scope="scope"><span>{{scope.row.tableComment}}</span></template>
        </el-table-column>
        <el-table-column label="菜单名称">
          <template slot-scope="scope"><span>{{scope.row.menuName}}</span></template>
        </el-table-column>
        <el-table-column label="生成时间">
          <template slot-scope="scope"><span>{{scope.row.genTime}}</span></template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" v-if="!scope.row.id" @click="showGenDialog(scope.row.tableName)">生成
            </el-button>
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
      <el-dialog title="提示" :visible.sync="genDialog" width="30%" center :destroy-on-close="true">
        <el-form :model="genForm" ref="genForm" :inline="true" label-width="180px">
          <el-form-item label="表名称" prop="tableName">
            <el-input v-model="genForm.tableName" placeholder="请输入表名称"></el-input>
          </el-form-item>
        </el-form>
        <div class="dialog_button">
          <el-button size="medium" type="primary" @click="submitForm('genForm')">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { sysGeneratorlistByPage, addGen } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";
export default {
  name: "SysGenerator",
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
      genDialog: false,

      genForm: { tableName: "" },
    };
  },
  created () {
    let obj = autoPageObjFun();
    this.tabH = obj.tabH;
    this.page.limit = obj.tabNum;
  },
  mounted () {
    this.generatorlistByPage();
  },
  methods: {
    async generatorlistByPage () {
      let result = await sysGeneratorlistByPage(this.page.page, this.page.limit, this.search).then((data) => {
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
      let result = await sysGeneratorlistByPage(page, this.page.limit).then(
        (data) => {
          let response = data.data;
          if (response.code === 0) {
            return response.data;
          } else {
            return this.$message.error(response.msg);
          }
        }
      );
      this.tableData = result.records;
      this.page.total = result.total;
    },
    searchTableData () {
      this.generatorlistByPage();
    },
    showGenDialog (tableName) {
      this.genForm.tableName = tableName;
      this.genDialog = true;
    },
    submitForm (formName) {
      // 表单验证
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.addGenInfo();
        } else {
          return false;
        }
      });
    },
    async addGenInfo () {
      let { data } = await addGen(this.genForm.tableName);
      if (data.code === 0) {
        this.generatorlistByPage();
        this.genDialog = false;
      }
    },
  },
};
</script>

<style>
</style>