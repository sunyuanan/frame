
import axios from "axios"
import router from "@/router/index"
import { Message, Loading } from 'element-ui';
import Vue from 'vue'
export function requestServer(httpUrl,method,param) {
  switch (method) {
    case "GET":
      return axios({
        url:httpUrl,
        method:"GET",
        params:param,
        dataType:'json',
      });
      break;
    case "POST":
      return axios({
        url:httpUrl,
        method:"POST",
        data:param,
        dataType:'json',
      });
      break;
    case "PUT":
      return axios({
        url:httpUrl,
        method:"PUT",
        data:param,
        dataType:'json'
      });
      break;
    case "DELETE":
      return axios({
        url:httpUrl,
        method:"DELETE",
        data:param,
        dataType:'json'
      })
  }
}
let loading;
function startLoading() {    //使用Element loading-start 方法
  loading = Loading.service({
    lock: true,
    text: '数据加载中......',
    background: 'rgba(0, 0, 0, 0.7)'
  })
}
function endLoading() {    //使用Element loading-close 方法
  loading.close()
}

let needLoadingRequestCount = 0
function showFullScreenLoading() {
  if (needLoadingRequestCount === 0) {
    startLoading()
  }
  needLoadingRequestCount++
}

function tryHideFullScreenLoading() {
  if (needLoadingRequestCount <= 0) return
  needLoadingRequestCount--
  if (needLoadingRequestCount === 0) {
    endLoading()
  }
}

axios.interceptors.request.use(
  config=>{
     showFullScreenLoading()
    let token=sessionStorage.getItem("token")
    if (token){
      config.headers.authorization=token; //每次请求之前将token带上
      return config;
    }
  },
  error => {
     tryHideFullScreenLoading();
    return new Promise((resolve,reject)=>{
      reject(error);
    })
  }
)

axios.interceptors.response.use(
  config=>{
     tryHideFullScreenLoading();
    if(config.data.code == 404040){ //token过期
      console.log(router);
      // router.push({
      //   path: "/login",
      // });

      router.push({ path: '/' })
    }
    return config;
  },
  error => {
     tryHideFullScreenLoading();
    if (error.response){
      let code=error.response.data.code;
      switch (error.response.status) {
        case 400:
          break;
      }
    }
   
    return new Promise((resolve,reject)=>{
      reject(error);
    })
  }
)
// 登录请求的方法(不需要token)
export const httpRequest=(url,type,param)=>{
  let result =new Promise((resolve,reject)=>{
    $.ajax({
      url:url,
      type:type,
      data:JSON.stringify(param),
      contentType:'application/json',
      dataType:"json",
      success: function (data) {
        console.log(data);
        resolve(data);
      },
      error: function (jqXHR) {
        reject(jqXHR);
      }
    })
  })
  return result;
}














