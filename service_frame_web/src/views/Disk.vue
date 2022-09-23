<template>
  <div class="main_container">
    <h2>当前计算机盘符使用情况</h2>
    <div class="flex" id="flex_dt">

    </div>
  </div>
</template>

<script>
import { diskInfo } from "@/api/httpApi";
import { diskpie } from '@/api/echartConfig/config'
export default {
  name: 'Disk',
  data () {
    return {

    }
  },
  //生命周期 - 创建完成（访问当前this实例）
  created () {

  },
  //生命周期 - 挂载完成（访问DOM元素）
  mounted () {
    this.getDistInfo();
  },
  methods: {
    async getDistInfo () {
      let result = await diskInfo().then((data) => {
        let response = data.data;
        if (response.code === 0) {
          return response.data;
        } else {
          return this.$message.error(response.msg);
        }
      });

      this.autoDiskPie(result);
    },
    autoDiskPie (result) {



      for (let i = 0; i < result.length; i++) {


        $("#flex_dt").append('<div class="flex_box" style="text-align: center; flex: 1;"><div  style="width: 350px;height: 350px;" id="' + result[i].name + '"></div></div>')

        let tempChart = this.$echarts.init(document.getElementById("" + result[i].name + ""));
        let option = diskpie(result[i]);
        tempChart.setOption(option);


      }

    }

  }
}
</script>
<style scoped>
/* @import url(); 引入css类 */
h2 {
  text-align: center;
  margin: 10px 0 50px 0;
}
.flex {
  display: flex;
  flex-flow: wrap;
}
</style>