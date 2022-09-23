<template>
  <div class="main_container">
    <el-row :gutter="40">
      <el-col :span="6">
        <div class="">
          <div style="margin-top:10px;display: flex;align-items: center;">树形数据
          </div>
          <el-tree style="margin-top:40px" node-key="id" :data="treeData" :props="defaultProps"
            @node-click="handleNodeClick" :default-expanded-keys="expandArray">
          </el-tree>
        </div>
      </el-col>
      <el-col :span="18">
        <div class="tab_container">
          <div class="operation">
            <el-button size="medium" type="primary" @click="showDialog()">添加</el-button>
            <el-input class="search_input" v-model="search" placeholder="输入名称" @input="searchTableData()"
              suffix-icon="el-icon-search">
            </el-input>
          </div>
          <el-table :data="tableData" :height="tabH">
            <el-table-column label="编码">
              <template slot-scope="scope"><span>{{scope.row.sdCode}}</span></template>
            </el-table-column>
            <el-table-column label="名称">
              <template slot-scope="scope"><span>{{scope.row.sdName}}</span></template>
            </el-table-column>
            <el-table-column label="类型">
              <template slot-scope="scope"><span>{{scope.row.type}}</span></template>
            </el-table-column>
            <el-table-column label="备注" width="150px" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.bz}}</span></template>
            </el-table-column>
            <el-table-column label="操作" width="220px">
              <template slot-scope="scope">
                <el-button size="mini" type="primary" @click="editTreeDialog(scope.row)"> 编辑</el-button>
                <el-button size="mini" type="danger" @click="deleteTreeInfo(scope.row.id)"> 删除</el-button>
              </template>
            </el-table-column>
          </el-table>
          <div class="page">
            <el-pagination background @current-change="pageFun" :current-page.sync="page.page" :page-size="page.limit"
              layout="total, prev, pager, next, jumper" :total="page.total">
            </el-pagination>
          </div>
        </div>
      </el-col>
    </el-row>
    <div class="dialog_container">
      <el-dialog :title="title" :visible.sync="dialog" width="30%" center @close="clearFormData()">
        <el-form :model="form" :rules="rules" ref="form" :inline="true" label-width="130px">
          <!--  <el-form-item label="类型" prop="type">
            <el-select v-model="form.type" filterable placeholder="请选择">
              <el-option v-for="item in options" :key="item.id" :label="item.name" :value="item.id">
              </el-option>
            </el-select>
          </el-form-item> -->
          <el-form-item label="名称" prop="sdName">
            <el-input v-model="form.sdName" placeholder="请输入菜单名称"></el-input>
          </el-form-item>
          <el-form-item label="编码" prop="sdCode">
            <el-input v-model="form.sdCode" placeholder="请输入菜单名称"></el-input>
          </el-form-item>
          <el-form-item label="备注" prop="bz">
            <el-input v-model="form.bz" placeholder="请输入菜单名称"></el-input>
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
import { getTreeALL, getTreePage, addTree, editTree, deleteTree } from "@/api/httpApi";
import { pageObj, autoPageObjFun, generateTree } from "@/api/staticType";
export default {
  name: 'Tree',
  data () {
    return {
      tableData: [],
      tabH: 0,
      page: {
        total: 0,
        limit: 0,
        page: pageObj.currentPage,
      },
      search: "",
      treeData: [],
      defaultProps: {
        children: 'children',
        label: 'sdName'
      },
      pid: 0,
      id: null,
      dialog: false,
      form: {},
      rules: {
        sdName: [
          { required: true, message: '请输入名称', trigger: 'blur' },
        ],
        sdCode: [
          { required: true, message: '请输入编码', trigger: 'blur' },
        ],
      },
      title: "新增树数据",
      expandArray: [],
      options: [],
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
    this.getTreeALL();
  },
  methods: {
    async deleteTreeInfo (id) {
      let ids = [];
      ids.push(id);
      let { data } = await deleteTree(ids);
      if (data.code === 0) {
        this.tableData = [];
        this.treeData = [];
        this.getTreeALL();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    editTreeDialog (row) {
      this.form = row;
      this.id = row.id;
      this.title = "编辑树数据";
      this.dialog = true;
    },
    submitForm (formName) {
      let sdName = this.form.sdName;
      let sdCode = this.form.sdCode;
      let bz = this.form.bz;
      let pid = this.pid;
      let id = this.id;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (id == null) {
            this.addTreeInfo(sdName, sdCode, bz, pid);
          } else {
            this.editTreeInfo(id, sdName, sdCode, bz, pid);
          }
        } else {
          return false;
        }
      });
    },
    async addTreeInfo (sdName, sdCode, bz, pid) {
      let { data } = await addTree(sdName, sdCode, bz, pid);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async editTreeInfo (id, sdName, sdCode, bz, pid) {
      let { data } = await editTree(id, sdName, sdCode, bz, pid);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    showDialog () {
      this.title = "新增树数据";
      this.dialog = true;
    },
    clearFormData () {
      this.$refs['form'].resetFields();
      this.form = {};
      this.dialog = false;
      this.tableData = [];
      this.treeData = [];
      this.id = null;
      this.getTreeALL();
    },
    async getTreeALL () {
      let tempArray = this.treeData;
      let result = await getTreeALL().then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      generateTree(result, tempArray);
      this.expandArray = [this.pid];
      this.treePage();
    },
    async treePage () {
      let result = await getTreePage(this.page.page, this.page.limit, this.pid, this.search).then((data) => {
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
      let result = await getTreePage(page, this.page.limit, this.pid, this.search).then((data) => {
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
    handleNodeClick (val) {
      this.pid = val.id;
      this.treePage();
    },
    searchTableData () {
      this.treePage();
    },
  }
}
</script>
<style scoped>
.add {
  font-size: 18px;
  cursor: pointer;
}
.add:hover {
  color: #409eff;
}
.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  padding-right: 8px;
}
/* @import url(); 引入css类 */
</style>