/**
 *  分页配置
 *  currentPage 页码
 *  currentCount 页数
 */
export const pageObj = {
  currentPage: 0,
  currentCount: 14,
  currentTen: 10,
  currentTwelve: 12,
  currentFourteen: 14,
  currentSixteen: 16,
  currentEighteen: 18,
  currentTwenty: 20,
}

/* 自动计算表格高度 */
export let autoPageObjFun=(val)=>{
  if(val == undefined){
    val = 0
  }
  let tabH = (document.body.scrollHeight - 60 - 30 - 60 - 60-val);
  let tabNum = ((tabH / 100).toFixed(0)*100)/50;
  return {tabH,tabNum:tabNum-1};
}



/**
 * 生成树结构
 * @param jsonData  对象数组
 * @param result  需要接受的数组
 * @returns
 */
 export const generateTree = (jsonData, result) => {
  let temp = {},
    i = 0,
    j = 0,
    len = jsonData.length
  for (; i < len; i++) {
    temp[jsonData[i]['id']] = jsonData[i] // 以id作为索引存储元素，可以无需遍历直接定位元素
  }
  for (; j < len; j++) {
    let currentElement = jsonData[j]
    let tempCurrentElementParent = temp[currentElement['sdPid']] // 临时变量里面的当前元素的父元素
    if (tempCurrentElementParent) { // 如果存在父元素
      if (!tempCurrentElementParent['children']) { // 如果父元素没有chindren键
        tempCurrentElementParent['children'] = [] // 设上父元素的children键
      }
      tempCurrentElementParent['children'].push(currentElement) // 给父元素加上当前元素作为子元素
    } else { // 不存在父元素，意味着当前元素是一级元素
      result.push(currentElement);
    }
  }
  return result;
}


/**
 * map 通过value找key
 */
export let mapFindKey = (map, value) => {
  let newMap = new Map();
  map.forEach(function (value, key) {
    newMap.set(value, key);
  });
  return newMap.get(value);
}


/**
 * 获取字典里面的数组
 * @param dictType  字典里面的dictType
 */
 export let getPeerDictionary=(dictType)=>{
  let map=new Map();
  let data=JSON.parse(sessionStorage.getItem("data"))||{};
  let response=data.data;
  Object.keys(response).map(key=>{
    map.set(response[key].dictType,response[key].list);
  });
  return map.get(dictType);
}


/** 时间格式返回 */ 
export let  dateFormat=(fmt, date)=> {
    let ret;
    const opt = {
        "Y+": date.getFullYear().toString(),        // 年
        "m+": (date.getMonth() + 1).toString(),     // 月
        "d+": date.getDate().toString(),            // 日
        "H+": date.getHours().toString(),           // 时
        "M+": date.getMinutes().toString(),         // 分
        "S+": date.getSeconds().toString()          // 秒
        // 有其他格式化字符需求可以继续添加，必须转化成字符串
    };
    for (let k in opt) {
        ret = new RegExp("(" + k + ")").exec(fmt);
        if (ret) {
            fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
        };
    };
    return fmt;
}