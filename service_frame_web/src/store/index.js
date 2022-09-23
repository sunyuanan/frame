import userStore from "./userStore.js"
import Vue from "vue"
import Vuex from "vuex"
Vue.use(Vuex);
export  default new Vuex.Store({
  modules:{
    userInfo:userStore
    }
})
