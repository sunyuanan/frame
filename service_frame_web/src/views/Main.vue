<template>
  <div class="main_container">
    token:
    <br>
    {{token}}
  </div>
</template>

<script>
export default {
  name: "Main",
  data () {
    return {
      token: sessionStorage.getItem("token")
    };
  },
  components: {},
  mounted () { },
  methods: {},
};
</script>

<style>
</style>