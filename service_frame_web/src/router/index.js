import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

const originalPush = Router.prototype.push
Router.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

export default new Router({
  mode: 'hash',
  routes: [
    {
      path: '/',
      name: '/',
      component: () => import("@/views/Login")
    }, {
      path: '/index',
      name: "Index",
      component: () => import("@/views/Index"),
      children: [
        {
          path: "/main",
          name: "Main",
          component: () => import("@/views/Main")
        },
        {
          path: "/sysGenerator",
          name: "SysGenerator",
          component: () => import("@/views/SysGenerator")
        },
        {
          path: '/doc',
          name: "doc",
          component: () => import("@/views/Doc")
        },
        {
          path: '/job',
          name: "Job",
          component: () => import("@/views/Job")
        },
        {
          path: '/sysLog',
          name: "SysLog",
          component: () => import("@/views/SysLog")
        },
        {
          path: '/menus',
          name: "Menus",
          component: () => import("@/views/Menus")
        },
        {
          path: '/sysErrorLog',
          name: "SysErrorLog",
          component: () => import("@/views/SysErrorLog")
        },
        {
          path: '/dict',
          name: "Dict",
          component: () => import("@/views/Dict")
        } ,
        {
          path: '/sql',
          name: "Sql",
          component: () => import("@/views/Sql")
        },
        {
          path: '/sysUser',
          name: "SysUser",
          component: () => import("@/views/SysUser")
        },
        {
          path: '/sysRole',
          name: "SysRole",
          component: () => import("@/views/SysRole")
        },
        {
          path: '/tree',
          name: "Tree",
          component: () => import("@/views/Tree")
        },
        {
          path: '/disk',
          name: "Disk",
          component: () => import("@/views/Disk")
        },  
        {
          path: '/sqlInjection',
          name: "SqlInjection",
          component: () => import("@/views/SqlInjection")
        },  
        {
          path: '/file',
          name: "File",
          component: () => import("@/views/File")
        },  
        {
          path: '/backIp',
          name: "backIp",
          component: () => import("@/views/backIp")
        },  
        {
          path: '/whiteRegion',
          name: "whiteRegion",
          component: () => import("@/views/whiteRegion")
        },  
        
      ]
    }
  ]
})
