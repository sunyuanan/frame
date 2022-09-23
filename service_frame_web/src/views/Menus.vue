<template>
  <div class="main_container">
    <div class="tab_container">
      <div class="operation">
        <el-button size="medium" type="primary" @click="showMenusDiglog()">添加菜单</el-button>
      </div>
      <el-table :data="tableData" :height="tabH" default-expand-all row-key="id"
        :tree-props="{children: 'children', hasChildren: 'hasChildren'}">
        <el-table-column label="菜单名称">
          <template slot-scope="scope"><span>{{scope.row.name}}</span></template>
        </el-table-column>
        <el-table-column label="urlWeb">
          <template slot-scope="scope"><span>{{scope.row.urlWeb}}</span></template>
        </el-table-column>
        <el-table-column label="父级名称">
          <template slot-scope="scope"><span>{{scope.row.pidName}}</span></template>
        </el-table-column>
        <el-table-column label="状态">
          <template slot-scope="scope">
            <el-switch :value="scope.row.status" active-color="#13ce66" inactive-color="#ff4949" active-value="0"
              inactive-value="1">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" @click="getMenusInfo(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click=" deleteMenusInfo(scope.row.id)">删除</el-button>
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
          <el-form-item label="所属菜单" prop="pid">
            <el-select v-model="form.pid" filterable placeholder="请选择">
              <el-option v-for="item in options" :key="item.id" :label="item.name" :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="菜单名称" prop="name">
            <el-input v-model="form.name" placeholder="请输入菜单名称"></el-input>
          </el-form-item>
          <el-form-item label="前台URL">
            <el-input v-model="form.urlWeb" placeholder="请输入前台URL 例:(/xxxxx)"></el-input>
          </el-form-item>
          <el-form-item label="排序" prop="orderNum">
            <el-input v-model="form.orderNum" placeholder="请输入描述"></el-input>
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-switch v-model="form.status" active-color="#13ce66" inactive-color="#ff4949" active-value="0"
              inactive-value="1">
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
import { sysMenuslistByPage, getFirstMenus, addMenus, deleteMenus, updateMenus } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";
export default {
  name: 'Menus',
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
        pid: "0",
        status: "0"
      },
      options: [],
      value: '',
      rules: {
        pid: [
          { required: true, message: '请选择所属菜单', trigger: 'blur' },
        ],
        name: [
          { required: true, message: '请输入菜单名称', trigger: 'blur' },
        ],
        orderNum: [
          { required: true, message: '请输入排序', trigger: 'blur' },
        ],
      },
      menusId: null
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
    getMenusInfo (row) {
      this.menusId = row.id;
      this.getFirstMenus(row.id);
      this.form = row;
      this.title = "编辑菜单"
      this.dialog = true;
      this.listByPage();
    },
    async deleteMenusInfo (id) {
      let result = await deleteMenus(id).then((data) => {
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
      let id = this.menusId;
      let name = this.form.name;
      let pid = this.form.pid;
      let urlWeb = this.form.urlWeb;
      let orderNum = this.form.orderNum;
      let status = this.form.status
      // 表单验证
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (id == null) {
            this.addMenusInfo(name, pid, urlWeb, orderNum, status);
          } else {
            this.updateMenusInfo(id, name, pid, urlWeb, orderNum, status);
          }
        } else {
          return false;
        }
      });
    },
    async updateMenusInfo (id, name, pid, urlWeb, orderNum, status) {
      let type = 2;
      if (pid == "0") {
        type = 1;
      }
      let { data } = await updateMenus(id, name, pid, urlWeb, orderNum, status, type);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async addMenusInfo (name, pid, urlWeb, orderNum, status) {
      console.log(pid);
      let type = 2;
      if (pid == "0") {
        type = 1;
      }
      let { data } = await addMenus(name, pid, urlWeb, orderNum, status, type);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    clearFormData () {
      // 清空表单信息
      this.$refs['form'].resetFields();
      this.form = {
        pid: "0",
        status: "0"
      };
      this.menusId = null;
      this.dialog = false;
      this.listByPage();
    },
    async getFirstMenus (id) {
      let result = await getFirstMenus(1, id, 0).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });

      this.options = result;
      this.options.unshift({ id: "0", name: "顶级菜单" })
    },
    showMenusDiglog () {
      this.getFirstMenus();
      this.title = "添加菜单"
      this.dialog = true;
    },
    async listByPage () {
      let result = await sysMenuslistByPage(this.page.page, this.page.limit).then((data) => {
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
      let result = await sysMenuslistByPage(page, this.page.limit, this.search).then((data) => {
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
  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>