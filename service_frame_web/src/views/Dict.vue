<template>
  <div class="main_container">
    <el-row :gutter="40">
      <el-col :span="12">
        <div class="tab_container">
          <div class="operation">
            <el-button type="primary" size="medium" @click="showTypeDialog()">添加类型</el-button>
            <el-input class="search_input" v-model="typeName" placeholder="输入类型名称" @input="searchDictTypeTableData()"
              suffix-icon="el-icon-search"></el-input>
          </div>
          <el-table :data="dictTypeData" :height="tabH" border @row-click="showDictDataTable">
            <el-table-column label="名称" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.dictName}}</span></template>
            </el-table-column>
            <el-table-column label="类型" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.dictType}}</span></template>
            </el-table-column>
            <el-table-column label="状态" width="70px">
              <template slot-scope="scope"><span>
                  <el-switch :value="scope.row.status == 0?true:false" active-color="#13ce66" inactive-color="#ff4949"
                    disabled>
                  </el-switch>
                </span></template>
            </el-table-column>
            <el-table-column label="备注" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.remark}}</span></template>
            </el-table-column>
            <el-table-column label="操作">
              <template slot-scope="scope">
                <el-button size="mini" type="primary" @click=" showEditTypeDialog(scope.row)">编辑</el-button>
                <el-button size="mini" type="danger" @click=" deleteDictType(scope.row.id)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
          <div class="page">

            <el-pagination background @current-change="dictTypePageFun" :current-page.sync="dictTypePage.page"
              :page-size="dictTypePage.limit" layout="total, prev, pager, next, jumper" :total="dictTypePage.total">
            </el-pagination>

          </div>
        </div>
      </el-col>
      <el-col :span="12">
        <div class="tab_container">
          <div class="operation">
            <el-button type="primary" size="medium" @click="showDialog()">添加标签</el-button>
            <el-input class="search_input" v-model="typeLabel" placeholder="输入标签名称" @input="searchDictDataTableData()"
              suffix-icon="el-icon-search"></el-input>
          </div>
          <el-table :data="dictDataData" :height="tabH" border>
            <el-table-column label="标签" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.dictLabel}}</span></template>
            </el-table-column>
            <el-table-column label="键值" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.dictValue}}</span></template>
            </el-table-column>
            <el-table-column label="状态" width="70px">
              <template slot-scope="scope"><span>
                  <el-switch :value="scope.row.status == 0?true:false" active-color="#13ce66" inactive-color="#ff4949"
                    disabled>
                  </el-switch>
                </span></template>
            </el-table-column>
            <el-table-column label="备注" :show-overflow-tooltip="true">
              <template slot-scope="scope"><span>{{scope.row.remark}}</span></template>
            </el-table-column>
            <el-table-column label="操作">
              <template slot-scope="scope">
                <el-button size="mini" type="primary" @click=" showEditDataDialog(scope.row)">编辑</el-button>
                <el-button size="mini" type="danger" @click=" deleteDictData(scope.row.id)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
          <div class="page">

            <el-pagination background @current-change="dictDataPageFun" :current-page.sync="dictDataPage.page"
              :page-size="dictDataPage.limit" layout="total, prev, pager, next, jumper" :total="dictDataPage.total">
            </el-pagination>
          </div>
        </div>
      </el-col>
    </el-row>
    <div class="dialog_container">
      <el-dialog :title="typeObj.title" :visible.sync="typeObj.dialog" width="30%" center @close="clearTypeFormData()">
        <el-form :model="typeObj.typeform" :rules="typeObj.typerules" ref="typeForm" :inline="true" label-width="130px">
          <el-form-item label="名称" prop="dictName">
            <el-input v-model="typeObj.typeform.dictName" placeholder="请输入名称"></el-input>
          </el-form-item>
          <el-form-item label="类型" prop="dictType">
            <el-input v-model="typeObj.typeform.dictType" placeholder="请输入名称"></el-input>
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-input v-model="typeObj.typeform.remark" placeholder="请输入名称"></el-input>
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-switch v-model="typeObj.typeform.status" active-color="#13ce66" inactive-color="#ff4949"
              active-value="0" inactive-value="1">
            </el-switch>
          </el-form-item>
        </el-form>
        <div class="dialog_button">
          <el-button size="medium" type="primary" @click="submitTypeForm('typeForm')">确 定</el-button>
          <el-button size="medium" type="primary" @click="clearTypeFormData()">取 消</el-button>
        </div>
      </el-dialog>
      <el-dialog :title="dataObj.title" :visible.sync="dataObj.dialog" width="30%" center @close="clearDataFormData()">
        <el-form :model="dataObj.form" :rules="dataObj.rules" ref="dataForm" :inline="true" label-width="130px">
          <el-form-item label="标签" prop="dictLabel">
            <el-input v-model="dataObj.form.dictLabel" placeholder="请输入名称"></el-input>
          </el-form-item>
          <el-form-item label="键值" prop="dictValue">
            <el-input v-model="dataObj.form.dictValue" placeholder="请输入名称"></el-input>
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-input v-model="dataObj.form.remark" placeholder="请输入名称"></el-input>
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-switch v-model="dataObj.form.status" active-color="#13ce66" inactive-color="#ff4949" active-value="0"
              inactive-value="1">
            </el-switch>
          </el-form-item>
        </el-form>
        <div class="dialog_button">
          <el-button size="medium" type="primary" @click="submitDataForm('dataForm')">确 定</el-button>
          <el-button size="medium" type="primary" @click="clearDataFormData()">取 消</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import { dictTypeByPage, dictDataByPage, addDictType, editDictType, deleteDictType, addDictData, editDictData, deleteDictData } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";
export default {
  name: 'Dict',
  data () {
    return {
      dictTypeData: [],
      dictDataData: [],
      tabH: 0,
      dictTypePage: {
        total: 0,
        limit: 0,
        page: pageObj.currentPage,
      },
      dictDataPage: {
        total: 0,
        limit: 0,
        page: pageObj.currentPage,
      },
      typeName: "",
      typeLabel: "",
      typeId: null,
      dictType: null,

      typeObj: {
        title: "新增类型",
        typeform: { status: "0" },
        typerules: {},
        dialog: false,
        id: null
      },
      dataObj: {
        title: "新增标签",
        form: { status: "0" },
        rules: {},
        dialog: false,
        id: null
      }
    }
  },
  //生命周期 - 创建完成（访问当前this实例）
  created () {
    let obj = autoPageObjFun();
    this.tabH = obj.tabH;
    this.dictTypePage.limit = obj.tabNum;
    this.dictDataPage.limit = obj.tabNum;
  },
  //生命周期 - 挂载完成（访问DOM元素）
  mounted () {
    this.dictTypeTableByPage();
  },
  methods: {
    async deleteDictData (id) {
      let ids = [];
      ids.push(id);
      await deleteDictData(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          this.dictDataTableByPage();
          return this.$message.success("删除成功");
        } else {
          return this.$message.error(response.msg);
        }
      });
    },
    showEditDataDialog (row) {
      this.dataObj.form = row;
      this.dataObj.id = row.id;
      this.dataObj.title = "编辑标签"
      this.dataObj.dialog = true;
    },
    submitDataForm (formName) {
      let id = this.dataObj.id;
      let dictLabel = this.dataObj.form.dictLabel;
      let dictValue = this.dataObj.form.dictValue;
      let remark = this.dataObj.form.remark;
      let status = this.dataObj.form.status;
      let typeId = this.typeId;
      let dictType = this.dictType
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (id == null) {
            this.addDictDataInfo(dictLabel, dictValue, remark, status, typeId, dictType);
          } else {
            this.editDictDataInfo(id, dictLabel, dictValue, remark, status, typeId);
          }
        } else {
          return false;
        }
      })
    },
    async editDictDataInfo (id, dictLabel, dictValue, remark, status, typeId) {
      let { data } = await editDictData(id, dictLabel, dictValue, remark, status, typeId);
      if (data.code === 0) {
        this.dictDataTableByPage();
        this.clearDataFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async addDictDataInfo (dictLabel, dictValue, remark, status, typeId, dictType) {
      let { data } = await addDictData(dictLabel, dictValue, remark, status, typeId, dictType);
      if (data.code === 0) {
        this.dictDataTableByPage();
        this.clearDataFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    showDialog () {
      if (this.typeId == null || this.typeId == "") {
        return this.$message.error("请选择字典类型");
      }
      this.dataObj.title = "新增标签"
      this.dataObj.dialog = true;
    },
    clearDataFormData () {
      this.$refs['dataForm'].resetFields();
      this.dataObj.dialog = false;
      this.dataObj.form = { status: "0" };
      this.dataObj.id = null;
      this.dictDataTableByPage();
    },
    async dictTypeTableByPage () {
      let result = await dictTypeByPage(this.dictTypePage.page, this.dictTypePage.limit, this.typeName).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.dictTypeData = result.records;
      this.dictTypePage.total = result.total;
    },
    async dictTypePageFun (page) {
      let result = await dictTypeByPage(page, this.dictTypePage.limit, this.typeName).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.dictTypeData = result.records;
      this.dictTypePage.total = result.total;

    },

    async dictDataTableByPage () {
      let typeId = this.typeId;
      let result = await dictDataByPage(this.dictDataPage.page, this.dictDataPage.limit, typeId, this.typeLabel).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });
      this.dictDataData = result.records;
      this.dictDataPage.total = result.total;
    },
    async dictDataPageFun (page) {
      let typeId = this.typeId;
      let result = await dictDataByPage(page, this.dictDataPage.limit, typeId, this.typeLabel).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });

      this.dictDataData = result.records;
      this.dictDataPage.total = result.total;
    },
    showTypeDialog () {
      this.typeObj.title = '添加类型'
      this.typeObj.dialog = true;
    },
    showEditTypeDialog (row) {
      this.typeObj.typeform = row
      this.typeObj.id = row.id
      this.typeObj.dialog = true;
      this.typeObj.title = '编辑类型'
    },
    clearTypeFormData () {
      this.$refs['typeForm'].resetFields();
      this.typeObj.dialog = false;
      this.typeObj.typeform = { status: "0" };
      this.typeObj.id = null;
      this.dictTypeTableByPage()
    },
    submitTypeForm (formName) {
      let typeId = this.typeObj.id
      let dictName = this.typeObj.typeform.dictName
      let dictType = this.typeObj.typeform.dictType
      let remark = this.typeObj.typeform.remark
      let status = this.typeObj.typeform.status
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (typeId == null) {
            this.addDictTypeInfo(dictName, dictType, remark, status);
          } else {
            this.editDictTypeInfo(typeId, dictName, dictType, remark, status);
          }
        } else {
          return false;
        }
      })
    },
    async addDictTypeInfo (dictName, dictType, remark, status) {
      let { data } = await addDictType(dictName, dictType, remark, status);
      if (data.code === 0) {
        this.dictTypeTableByPage();
        this.clearTypeFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async editDictTypeInfo (id, dictName, dictType, remark, status) {
      let { data } = await editDictType(id, dictName, dictType, remark, status);
      if (data.code === 0) {
        this.dictTypeTableByPage();
        this.clearTypeFormData();
        return this.$message.success(data.msg);
      } else {
        return this.$message.error(data.msg);
      }
    },
    async deleteDictType (id) {
      let ids = [];
      ids.push(id);
      await deleteDictType(ids).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          this.dictTypeTableByPage();
          this.dictDataTableByPage();
          this.typeId = null;
          return this.$message.success("删除成功");
        } else {
          return this.$message.error(response.msg);
        }
      });
    },
    searchDictTypeTableData () {
      this.dictTypeTableByPage();
    },
    searchDictDataTableData () {
      this.dictDataTableByPage();
    },
    showDictDataTable (data) {
      this.typeId = data.id
      this.dictType = data.dictType
      this.dictDataTableByPage()
    },
  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
</style>