
/**
 * @param number 数字
 * 处理日期
 */
export const formatDate=(number)=>{
  const date=new Date();
  let currentTime=date.getTime() + 1000*60*60*24*number;
  date.setTime(currentTime); //注意，这行是关键代码
  let tYear = date.getFullYear()
  let tMonth = date.getMonth()+1;
  let tDate = date.getDate();
  if(tMonth<10){
    tMonth='0'+tMonth;
  }
  if(tDate<10){
    tDate='0'+tDate;
  }
  return tYear+"-"+tMonth+"-"+tDate;
}

/**
 * 计算剩余时间
 * @param endDate 结束时间
 */
export const remainDate=(startDate,endDate)=>{
  let startTimestamp=new Date(startDate).getTime();
  let endTimestamp=new Date(endDate).getTime();
  let remainTime=endTimestamp-startTimestamp;
  let days = parseInt(remainTime / (1000 * 60 * 60 * 24));
  let hours = parseInt((remainTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  let minutes = parseInt((remainTime % (1000 * 60 * 60)) / (1000 * 60));
  let seconds = (remainTime % (1000 * 60)) / 1000;
  if(days>0){
    return days+'天';
  }else {
    return '一'
  }
}

/**
 * 处理日期相关
 * @param day     索引
 * @param param   参数类型
 */
export const CalendarTime=(day,param)=>{
  let today = new Date();
  let targetday_milliseconds=today.getTime() + 1000*60*60*24*day;
  today.setTime(targetday_milliseconds); //注意，这行是关键代码
  let tMonth = today.getMonth()+1;
  let tDate = today.getDate();
  let tweek=today.getDay();
  if(param==="date"){
    return tMonth+"月"+tDate+"日";
  }else if (param==="day") {
    switch (tweek) {
      case 0:
        return"星期天";
      case 1:
        return"星期一";
      case 2:
        return"星期二";
      case 3:
        return"星期三";
      case 4:
        return"星期四";
      case 5:
        return"星期五";
      case 6:
        return"星期六";
    }
  }else {
    switch (tweek) {
      case 0:
      case 6:
        return true;
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        return false;
    }
  }
}
export const getAge=(strAge)=>{
    let birArr = strAge.split("-");
    let birYear = birArr[0];
    let birMonth = birArr[1];
    let birDay = birArr[2];
    d = new Date();
    var nowYear = d.getFullYear();
    var nowMonth = d.getMonth() + 1; // 月份加1
    var nowDay = d.getDate();
    var returnAge;
    if (birArr == null) {
      return false
    };
    var d = new Date(birYear, birMonth - 1, birDay);
    if (d.getFullYear() == birYear && (d.getMonth() + 1) == birMonth && d.getDate() == birDay) {
      if (nowYear == birYear) {
        returnAge = 0;
      } else {
        var ageDiff = nowYear - birYear;
        if (ageDiff > 0) {
          if (nowMonth == birMonth) {
            var dayDiff = nowDay - birDay;
            if (dayDiff < 0) {
              returnAge = ageDiff - 1;
            } else {
              returnAge = ageDiff;
            }
          } else {
            var monthDiff = nowMonth - birMonth;
            if (monthDiff < 0) {
              returnAge = ageDiff - 1;
            } else {
              returnAge = ageDiff;
            }
          }
        } else {
          return  "出生日期晚于今天，数据有误"; //返回-1 表示出生日期输入错误 晚于今天
        }
      }
      return returnAge;
    } else {
      return ("输入的日期格式错误！");
    }
  }














