<template>

  <el-container>
    <el-header>
      <div>
        <span style="float: left;">后台管理系统</span>
        <span style="float: right;  cursor: pointer;" @click="loginOut()">退出</span>
      </div>
    </el-header>
    <el-container>
      <el-aside width="250px" height="100%">
        <el-menu default-active="main" class="el-menu-vertical-demo" :router="true">
          <el-scrollbar style="height:100%">
            <el-menu-item index="main">
              <i class="el-icon-s-home"></i>
              <span slot="title">首页</span>
            </el-menu-item>
            <el-menu-item index="sysGenerator">
              <i class="el-icon-menu"></i>
              <span slot="title">代码生成</span>
            </el-menu-item>
            <el-menu-item index="doc">
              <i class="el-icon-document"></i>
              <span slot="title">接口文档</span>
            </el-menu-item>
            <el-menu-item index="job">
              <i class="el-icon-setting"></i>
              <span slot="title">任务调度</span>
            </el-menu-item>
            <el-menu-item index="dict">
              <i class="el-icon-setting"></i>
              <span slot="title">数据字典</span>
            </el-menu-item>
            <el-menu-item index="menus">
              <i class="el-icon-setting"></i>
              <span slot="title">菜单配置</span>
            </el-menu-item>
            <el-menu-item index="disk">
              <i class="el-icon-setting"></i>
              <span slot="title">磁盘监控</span>
            </el-menu-item>
            <el-menu-item index="tree">
              <i class="el-icon-setting"></i>
              <span slot="title">树形数据</span>
            </el-menu-item>
            <el-menu-item index="file">
              <i class="el-icon-setting"></i>
              <span slot="title">附件管理</span>
            </el-menu-item>
            <el-submenu index="sqlManage">
              <template slot="title">
                <i class="el-icon-menu"></i>
                <span>sql管理</span>
              </template>
              <el-menu-item-group>
                <el-menu-item index="sql">
                  <i class="el-icon-setting"></i>
                  <span slot="title">SQL监控</span>
                </el-menu-item>
              </el-menu-item-group>
              <el-menu-item-group>
                <el-menu-item index="sqlInjection">
                  <i class="el-icon-setting"></i>
                  <span slot="title">SQL可视化</span>
                </el-menu-item>
              </el-menu-item-group>
            </el-submenu>
            <el-submenu index="user">
              <template slot="title">
                <i class="el-icon-menu"></i>
                <span>用户管理</span>
              </template>
              <el-menu-item-group>
                <el-menu-item index="sysUser">
                  <i class="el-icon-s-grid"></i>
                  <span slot="title">用户管理</span>
                </el-menu-item>
              </el-menu-item-group>
              <el-menu-item-group>
                <el-menu-item index="sysRole">
                  <i class="el-icon-s-grid"></i>
                  <span slot="title">角色管理</span>
                </el-menu-item>
              </el-menu-item-group>
            </el-submenu>
            <el-submenu index="log">
              <template slot="title">
                <i class="el-icon-menu"></i>
                <span>日志管理</span>
              </template>
              <el-menu-item-group>
                <el-menu-item index="sysLog">
                  <i class="el-icon-s-grid"></i>
                  <span slot="title">操作日志</span>
                </el-menu-item>
              </el-menu-item-group>
              <el-menu-item-group>
                <el-menu-item index="sysErrorLog">
                  <i class="el-icon-s-grid"></i>
                  <span slot="title">异常日志</span>
                </el-menu-item>
              </el-menu-item-group>
            </el-submenu>

            <el-submenu index="backList">
              <template slot="title">
                <i class="el-icon-menu"></i>
                <span>系统限制管理</span>
              </template>
              <el-menu-item-group>
                <el-menu-item index="backIp">
                  <i class="el-icon-s-grid"></i>
                  <span slot="title">黑名单IP管理</span>
                </el-menu-item>
              </el-menu-item-group>
              <el-menu-item-group>
                <el-menu-item index="whiteRegion">
                  <i class="el-icon-s-grid"></i>
                  <span slot="title">白名单地区管理</span>
                </el-menu-item>
              </el-menu-item-group>
            </el-submenu>
          </el-scrollbar>
        </el-menu>

      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>

  </el-container>
</template>

<script>
import { logout } from "@/api/httpApi";
export default {
  name: "Index",
  data () {
    return {};
  },
  components: {},
  mounted () {
    this.$router.push({
      path: "main",
    });
  },
  methods: {
    async loginOut () {
      await logout().then((data) => {
        let response = data.data;
        if (response.code === 0) {
          this.$router.push({
            path: "/",
          });
        } else {
          return this.$message.error(response.msg);
        }
      });
    },
  },
};
</script>

<style scoped>
.el-header {
  background-color: #f7f5f5;
  line-height: 60px;
  text-align: center;
  /* display: flex; */
  /* justify-content: center; */
  /* align-items: center; */
}
.el-menu,
.el-container {
  height: 100%;
  font-size: 16px;
}
.el-main {
  padding: 0;
  overflow: hidden;
}
.el-container {
  overflow-x: hidden;
}

.el-scrollbar >>> .el-scrollbar__wrap {
  overflow-x: hidden;
}
</style>