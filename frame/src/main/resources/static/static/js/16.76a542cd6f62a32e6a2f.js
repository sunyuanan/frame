webpackJsonp([16],{PTYu:function(t,e){},mlqX:function(t,e,s){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var i=s("Xxa5"),l=s.n(i),n=s("exGp"),a=s.n(n),o=s("7RZP"),r={name:"Index",data:function(){return{}},components:{},mounted:function(){this.$router.push({path:"main"})},methods:{loginOut:function(){var t=this;return a()(l.a.mark(function e(){return l.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,Object(o.S)().then(function(e){var s=e.data;if(0!==s.code)return t.$message.error(s.msg);t.$router.push({path:"/"})});case 2:case"end":return e.stop()}},e,t)}))()}}},u={render:function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("el-container",[s("el-header",[s("div",[s("span",{staticStyle:{float:"left"}},[t._v("后台管理系统")]),t._v(" "),s("span",{staticStyle:{float:"right",cursor:"pointer"},on:{click:function(e){return t.loginOut()}}},[t._v("退出")])])]),t._v(" "),s("el-container",[s("el-aside",{attrs:{width:"250px",height:"100%"}},[s("el-menu",{staticClass:"el-menu-vertical-demo",attrs:{"default-active":"main",router:!0}},[s("el-scrollbar",{staticStyle:{height:"100%"}},[s("el-menu-item",{attrs:{index:"main"}},[s("i",{staticClass:"el-icon-s-home"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("首页")])]),t._v(" "),s("el-menu-item",{attrs:{index:"sysGenerator"}},[s("i",{staticClass:"el-icon-menu"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("代码生成")])]),t._v(" "),s("el-menu-item",{attrs:{index:"doc"}},[s("i",{staticClass:"el-icon-document"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("接口文档")])]),t._v(" "),s("el-menu-item",{attrs:{index:"job"}},[s("i",{staticClass:"el-icon-setting"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("任务调度")])]),t._v(" "),s("el-menu-item",{attrs:{index:"dict"}},[s("i",{staticClass:"el-icon-setting"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("数据字典")])]),t._v(" "),s("el-menu-item",{attrs:{index:"menus"}},[s("i",{staticClass:"el-icon-setting"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("菜单配置")])]),t._v(" "),s("el-menu-item",{attrs:{index:"disk"}},[s("i",{staticClass:"el-icon-setting"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("磁盘监控")])]),t._v(" "),s("el-menu-item",{attrs:{index:"tree"}},[s("i",{staticClass:"el-icon-setting"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("树形数据")])]),t._v(" "),s("el-menu-item",{attrs:{index:"file"}},[s("i",{staticClass:"el-icon-setting"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("附件管理")])]),t._v(" "),s("el-submenu",{attrs:{index:"sqlManage"}},[s("template",{slot:"title"},[s("i",{staticClass:"el-icon-menu"}),t._v(" "),s("span",[t._v("sql管理")])]),t._v(" "),s("el-menu-item-group",[s("el-menu-item",{attrs:{index:"sql"}},[s("i",{staticClass:"el-icon-setting"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("SQL监控")])])],1),t._v(" "),s("el-menu-item-group",[s("el-menu-item",{attrs:{index:"sqlInjection"}},[s("i",{staticClass:"el-icon-setting"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("SQL可视化")])])],1)],2),t._v(" "),s("el-submenu",{attrs:{index:"user"}},[s("template",{slot:"title"},[s("i",{staticClass:"el-icon-menu"}),t._v(" "),s("span",[t._v("用户管理")])]),t._v(" "),s("el-menu-item-group",[s("el-menu-item",{attrs:{index:"sysUser"}},[s("i",{staticClass:"el-icon-s-grid"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("用户管理")])])],1),t._v(" "),s("el-menu-item-group",[s("el-menu-item",{attrs:{index:"sysRole"}},[s("i",{staticClass:"el-icon-s-grid"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("角色管理")])])],1)],2),t._v(" "),s("el-submenu",{attrs:{index:"log"}},[s("template",{slot:"title"},[s("i",{staticClass:"el-icon-menu"}),t._v(" "),s("span",[t._v("日志管理")])]),t._v(" "),s("el-menu-item-group",[s("el-menu-item",{attrs:{index:"sysLog"}},[s("i",{staticClass:"el-icon-s-grid"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("操作日志")])])],1),t._v(" "),s("el-menu-item-group",[s("el-menu-item",{attrs:{index:"sysErrorLog"}},[s("i",{staticClass:"el-icon-s-grid"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("异常日志")])])],1)],2),t._v(" "),s("el-submenu",{attrs:{index:"backList"}},[s("template",{slot:"title"},[s("i",{staticClass:"el-icon-menu"}),t._v(" "),s("span",[t._v("系统限制管理")])]),t._v(" "),s("el-menu-item-group",[s("el-menu-item",{attrs:{index:"backIp"}},[s("i",{staticClass:"el-icon-s-grid"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("黑名单IP管理")])])],1),t._v(" "),s("el-menu-item-group",[s("el-menu-item",{attrs:{index:"whiteRegion"}},[s("i",{staticClass:"el-icon-s-grid"}),t._v(" "),s("span",{attrs:{slot:"title"},slot:"title"},[t._v("白名单地区管理")])])],1)],2)],1)],1)],1),t._v(" "),s("el-main",[s("router-view")],1)],1)],1)},staticRenderFns:[]};var c=s("VU/8")(r,u,!1,function(t){s("PTYu")},"data-v-32e5a40c",null);e.default=c.exports}});
//# sourceMappingURL=16.76a542cd6f62a32e6a2f.js.map