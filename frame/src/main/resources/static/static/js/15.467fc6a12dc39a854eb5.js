webpackJsonp([15],{jZoP:function(e,t){},"mCm+":function(e,t,a){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var n=a("Xxa5"),r=a.n(n),o=a("exGp"),s=a.n(o),l=a("7RZP"),i=a("QbhR"),c={name:"SysGenerator",data:function(){return{tableData:[],tabH:0,search:"",page:{total:0,limit:0,page:i.d.currentPage},genDialog:!1,genForm:{tableName:""}}},created:function(){var e=Object(i.a)();this.tabH=e.tabH,this.page.limit=e.tabNum},mounted:function(){this.generatorlistByPage()},methods:{generatorlistByPage:function(){var e=this;return s()(r.a.mark(function t(){var a;return r.a.wrap(function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,Object(l._1)(e.page.page,e.page.limit,e.search).then(function(t){var a=t.data;return 0===a.code?a.data:e.$message.error(a.msg)});case 2:a=t.sent,e.tableData=a.records,e.page.total=a.total;case 5:case"end":return t.stop()}},t,e)}))()},pageFun:function(e){var t=this;return s()(r.a.mark(function a(){var n;return r.a.wrap(function(a){for(;;)switch(a.prev=a.next){case 0:return a.next=2,Object(l._1)(e,t.page.limit).then(function(e){var a=e.data;return 0===a.code?a.data:t.$message.error(a.msg)});case 2:n=a.sent,t.tableData=n.records,t.page.total=n.total;case 5:case"end":return a.stop()}},a,t)}))()},searchTableData:function(){this.generatorlistByPage()},showGenDialog:function(e){this.genForm.tableName=e,this.genDialog=!0},submitForm:function(e){var t=this;this.$refs[e].validate(function(e){if(!e)return!1;t.addGenInfo()})},addGenInfo:function(){var e=this;return s()(r.a.mark(function t(){var a;return r.a.wrap(function(t){for(;;)switch(t.prev=t.next){case 0:return t.next=2,Object(l.e)(e.genForm.tableName);case 2:a=t.sent,0===a.data.code&&(e.generatorlistByPage(),e.genDialog=!1);case 5:case"end":return t.stop()}},t,e)}))()}}},u={render:function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"main_container"},[a("div",{staticClass:"tab_container"},[a("div",{staticClass:"operation"},[a("el-input",{staticClass:"search_input",attrs:{size:"medium",placeholder:"输入表名/表备注","suffix-icon":"el-icon-search"},on:{input:function(t){return e.searchTableData()}},model:{value:e.search,callback:function(t){e.search=t},expression:"search"}})],1),e._v(" "),a("el-table",{attrs:{data:e.tableData,height:e.tabH}},[a("el-table-column",{attrs:{label:"是否生成"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("span",[e._v(e._s(null==t.row.id?"否":"是"))])]}}])}),e._v(" "),a("el-table-column",{attrs:{label:"表名"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("span",[e._v(e._s(t.row.tableName))])]}}])}),e._v(" "),a("el-table-column",{attrs:{label:"表备注"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("span",[e._v(e._s(t.row.tableComment))])]}}])}),e._v(" "),a("el-table-column",{attrs:{label:"菜单名称"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("span",[e._v(e._s(t.row.menuName))])]}}])}),e._v(" "),a("el-table-column",{attrs:{label:"生成时间"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("span",[e._v(e._s(t.row.genTime))])]}}])}),e._v(" "),a("el-table-column",{attrs:{label:"操作"},scopedSlots:e._u([{key:"default",fn:function(t){return[t.row.id?e._e():a("el-button",{attrs:{size:"mini",type:"primary"},on:{click:function(a){return e.showGenDialog(t.row.tableName)}}},[e._v("生成\n          ")])]}}])})],1),e._v(" "),a("div",{staticClass:"page"},[a("el-pagination",{attrs:{background:"","current-page":e.page.page,"page-size":e.page.limit,layout:"total, prev, pager, next, jumper",total:e.page.total},on:{"current-change":e.pageFun,"update:currentPage":function(t){return e.$set(e.page,"page",t)},"update:current-page":function(t){return e.$set(e.page,"page",t)}}})],1)],1),e._v(" "),a("div",{staticClass:"dialog_container"},[a("el-dialog",{attrs:{title:"提示",visible:e.genDialog,width:"30%",center:"","destroy-on-close":!0},on:{"update:visible":function(t){e.genDialog=t}}},[a("el-form",{ref:"genForm",attrs:{model:e.genForm,inline:!0,"label-width":"180px"}},[a("el-form-item",{attrs:{label:"表名称",prop:"tableName"}},[a("el-input",{attrs:{placeholder:"请输入表名称"},model:{value:e.genForm.tableName,callback:function(t){e.$set(e.genForm,"tableName",t)},expression:"genForm.tableName"}})],1)],1),e._v(" "),a("div",{staticClass:"dialog_button"},[a("el-button",{attrs:{size:"medium",type:"primary"},on:{click:function(t){return e.submitForm("genForm")}}},[e._v("确 定")])],1)],1)],1)])},staticRenderFns:[]};var p=a("VU/8")(c,u,!1,function(e){a("jZoP")},null,null);t.default=p.exports}});
//# sourceMappingURL=15.467fc6a12dc39a854eb5.js.map