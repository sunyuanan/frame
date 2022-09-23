/**
 * 替换#号的方法，
 * @param str 需要替换的字符串
 */
export const replaceShiftThree=(str)=>{
  let tempStr=str.toString();
    if(tempStr.length<=1){
      return '#'+tempStr+'#'
    }else {
      return '#'+tempStr.replace(/,/g,'#')+'#';
    }
}
export default {
  debounce(fn, delay = 300) {   //默认300毫秒
    var timer;
    return function() {
      var args = arguments;
      if(timer) {
        clearTimeout(timer);
      }
      timer = setTimeout(() => {
        fn.apply(this, args);   // this 指向vue
      }, delay);
    };
  }
}
