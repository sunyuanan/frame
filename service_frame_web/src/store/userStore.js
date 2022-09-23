import  Vue from "vue"
import Vuex from "vuex"
Vue.use(Vuex)
const state={
    loginId:sessionStorage.getItem("userLoginId")|| null,
    roleId:sessionStorage.getItem("userLoginRoleId")||  null,
    areaCode:sessionStorage.getItem("areaCode")|| null,
    token:sessionStorage.getItem("token")||null,
    cellId:sessionStorage.getItem("cellId")||null,
}
const mutations={
  setLoginId(state,preload){  //  设置登录的Id
    state.loginId=preload;
  },
  setRoleId(state,preload){   //  设置角色的Id
    state.roleId=preload
  },
  setAreaCode(state,preload){ //  设置单位id
    state.areaCode=preload;
  },
  setToken(state,proload){
    state.token=proload;
  },
  SET_CELLID(state,proload){  // 设置监区id
    sessionStorage.setItem("cellId",proload)
    state.cellId=proload;
  }
}
const actions={
    updateLoginId(context,preoload){
      sessionStorage.setItem("userLoginId",preoload)
      context.commit("setLoginId",preoload);
    },
    updateRoleId(context,preload){
      sessionStorage.setItem("userLoginRoleId",preload);
      context.commit("setRoleId",preload);
    },
    updateAreaCode(context,preload){
      sessionStorage.setItem("areaCode",preload)
      context.commit("setAreaCode",preload);
    },
    updateToken(context,proload){
      sessionStorage.setItem("token",proload);
      context.commit("setToken",proload);
    }
}
export default {
  namespaced:true,
  state:state,
  mutations:mutations,
  actions:actions
}
