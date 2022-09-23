<template>
  <div class="main_container">
    <div class="tab_container">
      <div class="operation">
        <el-button size="medium" type="primary" @click="showFileDiglog()">添加附件</el-button>
        <el-input class="search_input" v-model="search" placeholder="附件大类/附件类型/原始名称/后缀名" @input="listByPage()"
          suffix-icon="el-icon-search"></el-input>
      </div>
      <el-table :data="tableData" :height="tabH" default-expand-all row-key="id">
        <el-table-column label="原始名称" :show-overflow-tooltip="true">
          <template slot-scope="scope"><span>{{scope.row.ysmc}}</span></template>
        </el-table-column>
        <el-table-column label="附件大类">
          <template slot-scope="scope"><span>{{scope.row.fjdl}}</span></template>
        </el-table-column>
        <el-table-column label="附件类型">
          <template slot-scope="scope"><span>{{scope.row.fjlx}}</span></template>
        </el-table-column>
        <el-table-column label="后缀名">
          <template slot-scope="scope"><span>{{scope.row.fjhzm}}</span></template>
        </el-table-column>
        <el-table-column label="创建时间">
          <template slot-scope="scope"><span>{{scope.row.createTime}}</span></template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="primary" @click="showEditFileDialog(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click=" deleteFileInfo(scope.row.id)">删除</el-button>
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
          <el-form-item label="附件大类" prop="fjdl">
            <el-select v-model="form.fjdl" filterable placeholder="请选择">
              <el-option v-for="item in fjdlList" :key="item.id" :label="item.dictLabel" :value="item.dictLabel">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="附件类型" prop="fjlx">
            <el-select v-model="form.fjlx" filterable placeholder="请选择">
              <el-option v-for="item in fjlxList" :key="item.id" :label="item.dictLabel" :value="item.dictLabel">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="附件上传">
            <el-upload class="upload-demo" :action="uploadAddress" multiple :limit="1" :on-success="handleAvatarSuccess"
              :file-list="fileList" :before-remove="beforeRemove">
              <el-button size="small" type="primary">点击上传</el-button>
            </el-upload>
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
import { httpRequestUrl } from "@/api/baseUrl";
import { addAttachement, publicAttachementListByPage, getDict, deleteFile, editAttachement } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";
export default {
  name: 'File',
  data () {
    return {
      search: "",
      tableData: [],
      tabH: 0,
      page: {
        total: 0,
        limit: 0,
        page: pageObj.currentPage,
      },
      dialog: false,
      title: "",
      form: {},
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
      fjdlList: [],
      fjlxList: [],
      fileList: [],
      templateParams: {},
      uploadAddress: httpRequestUrl + "/file/upload?authorization=" + sessionStorage.getItem("token"),
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
    this.getDictFjdl();
    this.getDictFjlx();
  },
  methods: {
    async deleteFileInfo (id) {
      let ids = [];
      ids.push(id);
      await deleteFile(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          this.listByPage();
          return this.$message.success("删除成功");
        } else {
          return this.$message.error(response.msg);
        }
      });
    },
    showEditFileDialog (row) {
      this.form = row;
      this.id = row.id;
      this.title = "编辑附件"
      this.dialog = true;
    },
    submitForm (formName) {
      let id = this.id;
      let fjdl = this.form.fjdl;
      let fjlx = this.form.fjlx;
      let tempPath = this.templateParams.filePath;
      let realName = this.templateParams.realName
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (id == null) {
            this.addFile(fjdl, fjlx, tempPath, realName);
          } else {
            this.editFile(id, fjdl, fjlx, tempPath, realName);
          }
        } else {
          return false;
        }
      });
    },
    async editFile (id, fjdl, fjlx, tempPath, realName) {
      let { data } = await editAttachement(id, fjdl, fjlx, tempPath, realName);
      if (data.code === 0) {
        this.clearFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async addFile (fjdl, fjlx, tempPath, realName) {
      let { data } = await addAttachement(fjdl, fjlx, tempPath, realName);
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
      this.fileList = []
      this.id = null;
      this.dialog = false;
      this.listByPage();
    },
    async getDictFjdl () {
      let result = await getDict("majorCategories").then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.fjdlList = result;
    },
    async getDictFjlx () {
      let result = await getDict("systemPathConfiguration").then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.fjlxList = result;
    },
    async listByPage () {
      let result = await publicAttachementListByPage(this.page.page, this.page.limit, this.search).then((data) => {
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
      let result = await publicAttachementListByPage(page, this.page.limit, this.search).then((data) => {
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
    showFileDiglog () {
      this.title = "添加附件"
      this.dialog = true
    },

    handleAvatarSuccess (res, file) {  //  文件上传
      console.log(res);
      console.log(file);
      if (res.code === 0) {
        this.templateParams.filePath = res.data.filePath + res.data.fileName;
        this.templateParams.realName = res.data.realName


      }
      let params = {
        name: res.data.realName,
      };
      this.fileList = []
      this.fileList.push(params);
    },
    beforeRemove (file, fileList) {
      this.fileList = [];
      this.templateParams.filePath = null;
    }
  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>