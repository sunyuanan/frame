<template>
  <iframe src="/doc.html" scrolling="auto" frameborder="0" id="iframe"></iframe>
</template>

<script>
export default {
  name: 'test',
  data () {
    return {

    }
  },
  //生命周期 - 创建完成（访问当前this实例）
  created () {

  },
  //生命周期 - 挂载完成（访问DOM元素）
  mounted () {

  },
  methods: {
  }
}
</script>
<style scoped>
iframe {
  width: 100%;
  height: 100%;
  overflow: hidden;
  padding: 0;
  margin: 0;
}

/* @import url(); 引入css类 */
</style>