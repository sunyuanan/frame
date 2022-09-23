<template>
  <div class="main_container">
    <div class="tab_container">
      <div class="operation">
        <el-button type="primary" size="medium" @click="showDiglog()">添加角色</el-button>
        <el-input class="search_input" v-model="name" placeholder="输入角色名" @input="searchTableData()"
          suffix-icon="el-icon-search"></el-input>
      </div>
      <el-table :data="tableData" :height="tabH">
        <el-table-column label="角色名">
          <template slot-scope="scope"><span>{{scope.row.name}}</span></template>
        </el-table-column>
        <el-table-column label="创建时间">
          <template slot-scope="scope"><span>{{scope.row.createTime}}</span></template>
        </el-table-column>
        <el-table-column label="更新时间">
          <template slot-scope="scope"><span>{{scope.row.updateTime}}</span></template>
        </el-table-column>
        <el-table-column label="状态">
          <template slot-scope="scope">
            <el-switch :value="scope.row.status" active-color="#13ce66" inactive-color="#ff4949" active-value="1"
              inactive-value="0">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" @click="getRoleInfo(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click=" deleteRoleInfo(scope.row.id)">删除</el-button>
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
      <el-dialog :title="title" :visible.sync="dialog" width="80%" center @close="clearFormData()" top="3vh"
        :destroy-on-close="true">
        <el-form :model="form" :rules="rules" ref="form" :inline="true" label-width="80px">
          <el-form-item label="角色名" prop="name">
            <el-input v-model="form.name" placeholder="请输入角色名"></el-input>
          </el-form-item>
          <el-form-item label="描述" prop="description">
            <el-input v-model="form.description" placeholder="请输入描述"></el-input>
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-switch v-model="form.status" active-color="#13ce66" inactive-color="#ff4949" active-value="1"
              inactive-value="0">
            </el-switch>
          </el-form-item>
        </el-form>
        <el-row :gutter="30">
          <el-col :span="12">
            <h3>配置菜单 <el-checkbox v-model="menusVal" true-label="1" false-label="2" @change="menusSelectAll">全选
              </el-checkbox>
            </h3>
            <div style="height:600px;overflow:hidden;overflow-y:auto;">
              <el-tree style="margin-top:10px" ref="menusTree" :data="menusList" show-checkbox node-key="id"
                :props="defaultProps" :default-expand-all="true" :default-checked-keys="menusEdList">
              </el-tree>
            </div>
          </el-col>
          <el-col :span="12">
            <h3>配置接口权限
              <el-checkbox v-model="permissionVal" true-label="1" false-label="2" @change="permissionSelectAll">全选
              </el-checkbox>
            </h3>
            <div style="height:600px;overflow:hidden;overflow-y:auto;">
              <el-tree style="margin-top:10px" ref="permissionTree" :data="permissionList" show-checkbox node-key="id"
                :props="defaultProps" :default-expand-all="true" :default-checked-keys="permissionEdList">
              </el-tree>
            </div>
          </el-col>
        </el-row>
        <div class="dialog_button">
          <el-button size="medium" type="primary" @click="submitForm('form')">确 定</el-button>
          <el-button size="medium" type="primary" @click="clearFormData()">取 消</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { listRoleByPage, deleteRole, menusListByTree, permissionListByTree, permissionAndMenusList, addRole, editRole, getFirstMenus } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";
export default {
  name: 'SysRole',
  data () {
    return {
      tableData: [],
      tabH: 0,
      page: {
        total: 0,
        limit: 0,
        page: pageObj.currentPage,
      },
      form: { status: "1" },
      dialog: false,
      rules: {
        name: [
          { required: true, message: '请输入角色名', trigger: 'blur' },
        ],
      },
      title: "",
      name: "",
      id: null,
      menusList: [],
      permissionList: [],
      menusList1: [],
      permissionList1: [],
      defaultProps: {
        children: 'children',
        label: 'name'
      },
      menusEdList: [],
      permissionEdList: [],
      menusAllList: [],
      permissionAllList: [],
      checkEdList: [],
      menusVal: "2",
      permissionVal: "2"
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
    this.showMenusListByTree();
    this.showPermissionListByTree();
    this.showPermissionAndMenusAllList();
  },
  methods: {
    menusSelectAll (val) {
      if (val == 2) {
        this.$refs.menusTree.setCheckedKeys([]);
      } else {
        let ids = [];
        for (let i = 0; i < this.menusAllList.length; i++) {
          ids.push(this.menusAllList[i].id)
        }
        this.$refs.menusTree.setCheckedKeys(ids);
      }
    },
    permissionSelectAll (val) {
      if (val == 2) {
        this.$refs.permissionTree.setCheckedKeys([]);
      } else {
        let ids = [];
        for (let i = 0; i < this.permissionAllList.length; i++) {
          ids.push(this.permissionAllList[i].id)
        }
        this.$refs.permissionTree.setCheckedKeys(ids);
      }
    },
    getRoleInfo (row) {
      this.showPermissionAndMenusList(row);
    },
    submitForm (formName) {
      let id = this.id;
      let menusList = [];
      let menusObjList = this.$refs.menusTree.getCheckedNodes(false, true);
      for (let i = 0; i < menusObjList.length; i++) {
        menusList.push(menusObjList[i].id);
      }
      console.log(menusList);
      let permissionList = this.$refs.permissionTree.getCheckedKeys(true);
      let name = this.form.name;
      let description = this.form.description;
      let status = this.form.status;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (id == null) {
            this.addRoleInfo(name, description, status, menusList, permissionList);
          } else {
            this.editRoleInfo(id, name, description, status, menusList, permissionList);
          }
        } else {
          return false;
        }
      });
    },
    async addRoleInfo (name, description, status, menusList, permissionList) {
      var list = menusList.concat(permissionList);
      let { data } = await addRole(name, description, status, list);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async editRoleInfo (id, name, description, status, menusList, permissionList) {
      var list = menusList.concat(permissionList);
      let { data } = await editRole(id, name, description, status, list);
      if (data.code === 0) {
        this.clearFormData();

        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    showDiglog () {
      this.title = "添加角色"
      this.dialog = true;
    },
    clearFormData () {
      this.$refs['form'].resetFields();
      this.form = {
        status: "1"
      };
      this.id = null;
      this.menusEdList = [];
      this.permissionEdList = [];
      this.menusVal = "2";
      this.permissionVal = "2";
      this.dialog = false;
      this.listByPage();
    },
    async listByPage () {
      let result = await listRoleByPage(this.page.page, this.page.limit, this.name).then((data) => {
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
      let result = await listRoleByPage(page, this.page.limit, this.name).then((data) => {
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
    async deleteRoleInfo (id) {
      let ids = [];
      ids.push(id);
      await deleteRole(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          this.listByPage();
          return this.$message.success("删除成功");
        } else {
          return this.$message.error(response.msg);
        }
      });
    },
    async showMenusListByTree () {
      let result = await menusListByTree().then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.menusList = result
    },
    async showPermissionListByTree () {
      let result = await permissionListByTree().then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.permissionList = result
    },
    async showPermissionAndMenusList (row) {
      let result = await permissionAndMenusList(row.id).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.menusEdList = result.menusList;
      this.permissionEdList = result.permissionList;

      this.form = row;
      this.id = row.id
      this.title = "编辑角色"
      this.dialog = true;

    },
    async showPermissionAndMenusAllList () {
      this.permissionListData();
      this.permissionList1Data();
    },
    async permissionListData () {
      let result = await getFirstMenus(1).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.menusAllList = result;
    },
    async permissionList1Data () {
      let result = await getFirstMenus(3).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.permissionAllList = result;
    }
  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>