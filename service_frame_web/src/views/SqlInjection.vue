<template>
  <div class="sql_box">
    <el-row style="height:100%;">
      <el-col :span="3" style="height:100%;">
        <el-scrollbar style="height:100%">
          <div class="tables">
            <div>表格</div>
            <div v-for="itme in tables" @click="selectData(itme)"><i class="el-icon-tickets"></i>{{itme}}</div>
          </div>
          <el-divider></el-divider>
          <div class="views">
            <div>视图</div>
            <div v-for="itme in views" @click="selectData(itme)"><i class="el-icon-document-copy"></i>{{itme}}</div>
          </div>
        </el-scrollbar>
      </el-col>
      <el-col :span="21" style="height:100%">
        <div style="height:30%">
          <el-button size="mini" type="primary" @click="getSqlInjection()">运行</el-button>
          <textarea id="sqlBox" v-model="sql"></textarea>
        </div>
        <div class="sql_content" style="height:70%">
          <el-table :data="tableData" style="font-size: 12px; width:auto" border :max-height="tabH">
            <template v-for="(item,index) in title">
              <el-table-column :key="index" :label="item" :width="showWidth(item)" :show-overflow-tooltip="true">
                <template slot-scope="scope"><span>{{scope.row[item]}}</span></template>
              </el-table-column>
            </template>
          </el-table>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { sqlInjection, selectAllTable } from "@/api/httpApi";
import { pageObj, autoPageObjFun } from "@/api/staticType";
export default {
  name: "SqlInjection",
  data () {
    return {
      sql: "",
      title: [],
      tableData: [],
      show: false,
      tables: [],
      views: [],
      tabH: 0,
      selectedText: "",
    };
  },
  //生命周期 - 创建完成（访问当前this实例）
  created () {
    let obj = autoPageObjFun(140);
    this.tabH = obj.tabH;
  },
  //生命周期 - 挂载完成（访问DOM元素）
  mounted () {
    let _this = this;
    decodeURIComponent.onmousedown = function (event) {
      window.getSelection
        ? window.getSelection().removeAllRanges()
        : document.selection.empty();
    };
    //监听鼠标抬起
    document.onmouseup = function (event) {
      // 获取选中的文字
      var selectedText = null;
      if (window.getSelection) {
        // 标准模式
        selectedText = window.getSelection().toString();
      } else {
        // IE 系列
        selectedText = document.selection.createRange().text;
      }
      if (selectedText != null) {
        _this.selectedText = selectedText;
      }
    };

    document.onkeydown = function (e) {
      if (e.code == "F8") {
        _this.getSqlInjection();
      }
    };
    this.showTables();
  },
  methods: {
    async selectData (table) {
      let sql = "select * from " + table;
      let result = await sqlInjection(sql).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });

      this.initTable(result);
    },
    async showTables () {
      let result = await selectAllTable().then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });

      this.tables = [];
      this.views = [];

      for (let i = 0; i < result.length; i++) {
        if (result[i].tableComment == "VIEW") {
          this.views.push(result[i].tableName);
        } else {
          this.tables.push(result[i].tableName);
        }
      }
    },
    async getSqlInjection () {
      let sql = this.sql;
      if (this.selectedText != "" && this.selectedText != null) {
        sql = this.selectedText;
      }
      let result = await sqlInjection(sql).then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });

      this.initTable(result);
    },

    initTable (result) {
      this.title = [];
      for (var key in result[0]) {
        this.title.push(key);
      }
      this.tableData = result;
    },
    showWidth (val) {
      let width = (val.length + 2) * 10;
      if (val == "id" || val == "ID") {
        width = 150;
      }
      if (val == "ip" || val == "IP") {
        width = 100;
      }
      return width;
    },
  },
};
</script>
<style scoped>
.sql_box {
  width: 100%;
  height: 100%;
}
textarea {
  border: 0;
  background-color: rgba(241, 241, 241, 0.98);
  width: 100%;
  height: 100%;
  padding: 10px;
  resize: none;
  font-size: 14px;
}
.el-scrollbar >>> .el-scrollbar__wrap {
  overflow-x: hidden;
}
.tables,
.views {
  padding: 10px;
  font-size: 12px;
  line-height: 24px;
  cursor: pointer;
}
.tables div :hover,
.views div :hover {
  font-weight: bold;
}
.tables :hover i,
.views :hover i {
  font-weight: bold;
}

.tables i,
.views i {
  font-size: 16px;
  margin-right: 4px;
  color: #409eff;
}

/* @import url(); 引入css类 */
</style>