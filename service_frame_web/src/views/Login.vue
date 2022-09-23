<template>
  <div class="login-container">
    <div class="login">
      <h2 class="title">后台管理系统</h2>
      <el-form ref="form" :model="form" :rules="rules" label-width="0px">
        <el-form-item prop="user">
          <el-input v-model="form.user" placeholder="请输入账号"></el-input>
        </el-form-item>
        <el-form-item prop="psw">
          <el-input v-model="form.psw" show-password placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button id="formButton" style="width:100%" type="primary" @click="submitForm('form')">登录</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import { loginIn } from "@/api/httpApi";
export default {
  name: "Login",
  data () {
    return {
      form: {},
      rules: {
        user: [{ required: true, message: "请输入账号", trigger: "blur" }],
        psw: [{ required: true, message: "请输入密码", trigger: "blur" }],
      },
    };
  },
  components: {},
  mounted () {
    let _this = this;
    document.onkeydown = function (e) {
      var key = window.event.keyCode;
      if (key == 13) {
        $("#formButton").click();
      }
    }
  },
  methods: {
    submitForm (formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          loginIn(this.form.user, this.form.psw).then((data) => {
            console.log(data)
            if (data.code === 0) {

              console.log()
              sessionStorage.setItem("token", data.data.refreshToken);
              this.$router.push({
                path: "index",
              });
            } else {
              this.$message.error(data.msg);
            }
          }).catch((error) => {
            this.$message.error(error);
          });
        } else {
          // console.log("error submit!!");
          return false;
        }
      });
    },
  },
};
</script>

<style>
.login-container .title {
  margin-bottom: 20px;
}
.login-container .login {
  position: absolute;
  background-color: rgba(255, 255, 255, 0.6);
  left: 50%;
  top: 50%;
  width: 400px;
  padding: 50px 50px 30px 50px;
  transform: translate(-50%, -50%);
  border-radius: 20px;
  text-align: center;
}
</style>