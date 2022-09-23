<template>
  <div class="main_container">
    <el-row :gutter="40">
      <el-col :span="4">
        <div class="">
          <div style="margin-top:10px;display: flex;align-items: center;">树结构
          </div>
          <el-tree style="margin-top:40px" node-key="id" :data="treeData" :props="defaultProps"
            @node-click="handleNodeClick">
          </el-tree>
        </div>
      </el-col>
      <el-col :span="20">
        <div class="tab_container">
          <div class="operation">
            <el-button size="medium" type="primary" @click="showDialog()">添加</el-button>
            <el-input class="search_input" v-model="search" placeholder="输入登录账号/姓名" @input="searchTableData()"
              suffix-icon="el-icon-search">
            </el-input>
            <el-button size="medium" type="primary" @click="reset()">重置</el-button>
          </div>
          <el-table :data="tableData" :height="tabH">
            <el-table-column label="状态">
              <template slot-scope="scope"><span>{{showStatus(scope.row.status,scope.row.time)}}</span></template>
            </el-table-column>
            <el-table-column label="登录账号" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.account}}</span></template>
            </el-table-column>
            <el-table-column label="密码" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.password}}</span></template>
            </el-table-column>
            <el-table-column label="警号" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.jh}}</span></template>
            </el-table-column>
            <el-table-column label="证件号码" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.zjhm}}</span></template>
            </el-table-column>
            <el-table-column label="姓名" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.realName}}</span></template>
            </el-table-column>
            <el-table-column label="单位" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.sdName}}</span></template>
            </el-table-column>
            <el-table-column label="角色" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.roleName}}</span></template>
            </el-table-column>
            <el-table-column label="操作" width="300px">
              <template slot-scope="scope">
                <el-button size="mini" type="primary" @click="editUserDialog(scope.row)"> 编辑</el-button>
                <el-button size="mini" type="success" @click="untieUserInfo(scope.row.id)"> 解封</el-button>
                <el-button size="mini" type="danger" @click="lockUserInfoDialog(scope.row.id)"> 锁定</el-button>
                <el-button size="mini" type="danger" @click="deleteUserInfo(scope.row.relateId)"> 删除</el-button>
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
      <el-dialog :title="title" :visible.sync="dialog" width="50%" center @close="clearFormData()"
        :destroy-on-close="true">
        <el-row>
          <el-col :span="12">
            <p>单位：</p>
            <el-tree style="margin-top:20px" node-key="id" :data="treeData" :props="defaultProps"
              @node-click="handleNodeClick1">
            </el-tree>
          </el-col>
          <el-col :span="12">
            <el-form :model="form" :rules="rules" ref="form" :inline="true" label-width="80px">
              <el-form-item label="单位">
                <el-input v-model="sdName" placeholder="请选择单位" disabled></el-input>
              </el-form-item>
              <el-form-item label="姓名" prop="realName">
                <el-input v-model="form.realName" placeholder="请输入姓名"></el-input>
              </el-form-item>
              <el-form-item label="证件号码" prop="zjhm">
                <el-input v-model="form.zjhm" placeholder="请输入证件号码"></el-input>
              </el-form-item>
              <el-form-item label="警号" prop="jh">
                <el-input v-model="form.jh" placeholder="请输入警号"></el-input>
              </el-form-item>
              <el-form-item label="密码" prop="password">
                <el-input v-model="form.password" placeholder="请输入密码"></el-input>
              </el-form-item>
              <el-form-item label="角色" prop="roleId">
                <el-select v-if="id==null" v-model="form.roleIdList" placeholder="请选择角色" multiple>
                  <el-option v-for="item in roleList" :key="item.id" :label="item.name" :value="item.id">
                  </el-option>
                </el-select>
                <el-select v-else v-model="form.roleId" placeholder="请选择角色">
                  <el-option v-for="item in roleList" :key="item.id" :label="item.name" :value="item.id">
                  </el-option>
                </el-select>
              </el-form-item>
            </el-form>
          </el-col>
        </el-row>
        <div class="dialog_button">
          <el-button size="medium" type="primary" @click="submitForm('form')">确 定</el-button>
          <el-button size="medium" type="primary" @click="clearFormData()">取 消</el-button>
        </div>
      </el-dialog>
      <el-dialog title="锁定用户" :visible.sync="lockUserDialog" width="30%" center @close="clearLockUserFormData()"
        :destroy-on-close="true">
        <el-form :model="lockUserForm" ref="lockUserForm" :inline="true" label-width="180px">
          <el-form-item label="锁定时长" prop="roleId">
            <el-select v-model="lockUserForm.time" placeholder="请选择锁定时长">
              <el-option key="1" label="30分钟" value="30"></el-option>
              <el-option key="2" label="60分钟" value="60"></el-option>
              <el-option key="3" label="永久" value="-1"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div class="dialog_button">
          <el-button size="medium" type="primary" @click="submitLockUserForm('lockUserForm')">确 定</el-button>
          <el-button size="medium" type="primary" @click="clearLockUserFormData()">取 消</el-button>
        </div>
      </el-dialog>

    </div>
  </div>
</template>

<script>
import {
  getTreeALL,
  sysUserlistByPage,
  sysRolelist,
  addUser,
  editUser,
  deleteUser,
  lockUser,
  untieUser,
} from "@/api/httpApi";
import { pageObj, autoPageObjFun, generateTree } from "@/api/staticType";
export default {
  name: "SysUser",
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
        children: "children",
        label: "sdName",
      },
      title: "",
      form: {},
      rules: {},
      dialog: false,
      sdCode: "",
      roleList: [],
      sdName: "",
      id: null,
      lockUserDialog: false,
      lockUserForm: {},
    };
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
    this.showSysUserAll();
    this.getSysRolelist();
  },
  methods: {
    async untieUserInfo (id) {
      let { data } = await untieUser(id);
      if (data.code === 0) {
        this.showSysUserAll();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    submitLockUserForm (formName) {
      let id = this.lockUserForm.id;
      let time = this.lockUserForm.time;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.lockUserInfo(id, time);
        }
      });
    },
    async lockUserInfo (id, time) {
      let { data } = await lockUser(id, time);
      if (data.code === 0) {
        this.clearLockUserFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    clearLockUserFormData () {
      this.$refs["lockUserForm"].resetFields();
      this.lockUserForm = {};
      this.lockUserDialog = false;
      this.showSysUserAll();
    },
    lockUserInfoDialog (id) {
      this.lockUserForm.id = id;
      this.lockUserDialog = true;
    },
    showStatus (status, time) {
      if (status == 0) {
        return "正常";
      }
      if (status == 1) {
        return "锁定";
      }
      if (status == 2) {
        return "锁定(" + time + "分钟)";
      }
    },
    async deleteUserInfo (reateId) {
      let ids = [];
      ids.push(reateId);
      await deleteUser(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          this.showSysUserAll();
          return this.$message.success("删除成功");
        } else {
          return this.$message.error(response.msg);
        }
      });
    },
    editUserDialog (row) {
      this.title = "编辑用户";
      this.sdName = row.sdName;
      this.form = row;
      this.id = row.id;
      this.dialog = true;
    },
    submitForm (formName) {
      let id = this.id;
      let realName = this.form.realName;
      let zjhm = this.form.zjhm;
      let jh = this.form.jh;
      let password = this.form.password;
      let roleIdList = this.form.roleIdList;
      let sdCode = this.form.sdCode;
      let roleId = this.form.roleId;
      let relateId = this.form.relateId;
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (id == null) {
            this.addUserInfo(realName, zjhm, jh, password, roleIdList, sdCode);
          } else {
            this.editUserInfo(
              id,
              realName,
              zjhm,
              jh,
              password,
              roleId,
              sdCode,
              relateId
            );
          }
        } else {
          return false;
        }
      });
    },
    async editUserInfo (
      id,
      realName,
      zjhm,
      jh,
      password,
      roleId,
      sdCode,
      relateId
    ) {
      let { data } = await editUser(
        id,
        realName,
        zjhm,
        jh,
        password,
        roleId,
        sdCode,
        relateId
      );
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async addUserInfo (realName, zjhm, jh, password, roleIdList, sdCode) {
      let { data } = await addUser(
        realName,
        zjhm,
        jh,
        password,
        roleIdList,
        sdCode
      );
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    handleNodeClick1 (val) {
      this.sdName = val.sdName;
      this.form.sdCode = val.sdCode;
    },
    clearFormData () {
      this.$refs["form"].resetFields();
      this.form = {};
      this.dialog = false;
      this.sdName = "";
      this.showSysUserAll();
      this.id = null;
    },
    async getSysRolelist () {
      let result = await sysRolelist().then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.roleList = result;
    },
    showDialog () {
      this.title = "新增用户";
      this.dialog = true;
    },
    async showSysUserAll () {
      let result = await sysUserlistByPage(
        this.page.page,
        this.page.limit,
        this.search,
        this.sdCode
      ).then((data) => {
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
      let result = await sysUserlistByPage(
        page,
        this.page.limit,
        this.search,
        this.sdCode
      ).then((data) => {
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
      this.sdCode = val.sdCode;
      this.showSysUserAll();
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
    },
    searchTableData () {
      this.showSysUserAll();
    },
    reset () {
      this.sdCode = "";
      this.search = "";
      this.showSysUserAll();
    },
  },
};
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>