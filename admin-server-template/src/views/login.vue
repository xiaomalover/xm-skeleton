<template>
  <Row type="flex" justify="center" align="middle" class="login" @keydown.enter.native="submitLogin">
    <Col :xs="{span:22}" style="width: 368px;">
    <Row class="header">
      <img src="../assets/skeleton.png" width="220px" />

    </Row>

    <Alert type="error" show-icon v-if="error">{{errorMsg}}</Alert>

    <Row class="login-form" v-if="!socialLogining">


          <Form ref="usernameLoginForm" :model="form" :rules="rules" class="form">
            <FormItem prop="username">
              <Input v-model="form.username" prefix="ios-contact" size="large" clearable placeholder="请输入用户名" autocomplete="off" />
            </FormItem>
            <FormItem prop="password">
              <Input type="password" v-model="form.password" prefix="ios-lock" size="large" clearable placeholder="请输入密码" autocomplete="off" />
            </FormItem>

            <FormItem prop="captcha">
              <Row style="height:36px;">
                <Col span="17"><Input v-model="form.captcha" prefix="ios-locate-outline" size="large" style="width: 250px" clearable placeholder="请输入验证码"
                                      autocomplete="off"/></Col>
                <Col span="5"><img :src="imageBase64" alt="" @click="getCaptchaImg"/></Col>
              </Row>
            </FormItem>
          </Form>

      <Row type="flex" justify="space-between" class="code-row-bg" style="margin-top: -10px;">
        <Checkbox v-model="saveLogin" size="large">自动登录</Checkbox>
      </Row>
      <Row>
        <Button class="login-btn" type="primary" size="large" :loading="loading" @click="submitLogin" long>
                            <span v-if="!loading">登录</span>
                            <span v-else>登录中...</span>
                        </Button>
      </Row>

    </Row>

    <Row class="foot">

      <Row type="flex" justify="center" class="code-row-bg copyright">
        Copyright © 2018 <a href="#" target="_blank" style="margin:0 5px;">XM</a> 版权所有
      </Row>
    </Row>
    </Col>
  </Row>
</template>

<script>
    import Cookies from "js-cookie";
    import {getCaptcha, getJWT, initCaptcha, login, userInfo, getUploadDomain,} from "@/api/index";
    import util from "@/libs/util.js";

    export default {
  data() {
    return {
      imageBase64:"",
      captchaId:"",
      socialLogining: false,
      error: false,
      errorMsg: "",
      tabName: "username",
      saveLogin: true,
      loading: false,
      sending: false,
      sended: false,
      count: 60,
      countButton: "60 s",
      maxLength: 6,
      errorCode: "",
      form: {
        username: "",
        password: "",
        captcha:"",
      },
      rules: {
        username: [
          {
            required: true,
            message: "账号不能为空",
            trigger: "blur"
          }
        ],
        password: [
          {
            required: true,
            message: "密码不能为空",
            trigger: "blur"
          }
        ],
        captcha: [
            {
                required: true,
                message: "图形验证码不能为空",
                trigger: "blur"
            }
        ],
      }
    };
  },
  methods: {
      init() {
        this.getCaptchaImg();
      },

    showErrorMsg(msg) {
      this.error = true;
      this.errorMsg = msg;
    },

    getCaptchaImg()  {
        initCaptcha().then(res => {
            var _captchaId = res.result.captchaId;
            this.captchaId = _captchaId;
            getCaptcha(_captchaId).then(res => {
                this.imageBase64 = res.data;
            })
        })
    },

    countDown() {
      let that = this;
      if (this.count === 0) {
        this.sended = false;
        this.count = 60;
        return;
      } else {
        this.countButton = this.count + " s";
        this.count--;
      }
      setTimeout(function() {
        that.countDown();
      }, 1000);
    },
    submitLogin() {
      if (this.tabName === "username") {
        this.$refs.usernameLoginForm.validate(valid => {
          if (valid) {
            this.loading = true;
            login({
              username: this.form.username,
              password: this.form.password,
              saveLogin: this.saveLogin,
              captcha: this.form.captcha,
              captchaId: this.captchaId,
            }).then(res => {
              if (res.success === true) {
                this.setStore("accessToken", res.result);

                //设置图片主域名
                getUploadDomain().then(res => {
                  this.loading = false;
                  if (res.success === true) {
                    Cookies.set("imageDomain", res.result);
                  }
                });

                // 获取用户信息
                userInfo().then(res => {
                  if (res.success === true) {
                    // 避免超过大小限制
                    delete res.result.permissions;
                    if (this.saveLogin) {
                      // 保存7天
                      Cookies.set("userInfo", JSON.stringify(res.result), {
                        expires: 7
                      });
                    } else {
                      Cookies.set("userInfo", JSON.stringify(res.result));
                    }
                    this.setStore("userInfo", res.result);
                    this.$store.commit("setAvatarPath", res.result.avatar);
                    // 加载菜单
                    util.initRouter(this);
                    this.$router.push({
                      name: "home_index"
                    });
                  } else {
                    this.loading = false;
                  }
                });
              } else {
                this.loading = false;
              }
            });
          }
        });
      }
    },
  },

  mounted() {
      this.init();
  }

};
</script>

<style lang="less">
@import "./login.less";
</style>
