<style lang="less">
    @import "change-pass.less";
</style>

<template>
    <div>
        <Card>
            <p slot="title">
                <Icon type="key"></Icon>
                修改密码
            </p>
            <div>
                <Form
                        ref="editPasswordForm"
                        :model="editPasswordForm"
                        :label-width="100"
                        label-position="right"
                        :rules="passwordValidate"
                        style="width:450px"
                >
                    <FormItem label="原密码" prop="oldPass">
                        <Input type="password" v-model="editPasswordForm.oldPass" placeholder="请输入现在使用的密码"></Input>
                    </FormItem>
                    <FormItem label="新密码" prop="newPass">
                        <Input type="password" v-model="editPasswordForm.newPass" placeholder="请输入新密码，至少6位字符"></Input>
                    </FormItem>
                    <FormItem label="确认新密码" prop="rePass">
                        <Input type="password" v-model="editPasswordForm.rePass" placeholder="请再次输入新密码"></Input>
                    </FormItem>
                    <FormItem>
                        <Button type="primary" style="width: 100px;margin-right:5px" :loading="savePassLoading"
                                @click="saveEditPass">保存
                        </Button>
                        <Button @click="cancelEditPass">取消</Button>
                    </FormItem>
                </Form>
            </div>
        </Card>
    </div>
</template>

<script>
    import {changePass} from "@/api/index";
    import Cookies from "js-cookie";

    export default {
        name: "change_pass",
        data() {

            const validatePassword = (rule, value, callback) => {
                var reg = /(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9]/;
                if (!reg.test(value) || value.length < 6 || value.length > 16) {
                    callback(new Error("密码必须6-16位大小写字母和数字组合"));
                } else {
                    callback();
                }
            };

            const validateConfirmPassword = (rule, value, callback) => {
                if (value == '') {
                    callback(new Error('请输入确认密码'));
                } else if (this.editPasswordForm.newPass != value) {
                    callback(new Error('确认密码错误'));
                } else {
                    callback();
                }
            };

            return {
                id: "", // 登录用户的userId
                savePassLoading: false,
                editPasswordForm: {
                    oldPass: "",
                    newPass: "",
                    rePass: ""
                },
                passwordValidate: {
                    oldPass: [{required: true, message: "请输入原密码", trigger: "blur"}],
                    newPass: [
                        {required: true, message: "请输入新密码", trigger: "blur"},
                        {validator: validatePassword, trigger: "blur"}
                    ],
                    rePass: [
                        {validator: validateConfirmPassword, trigger: "blur"}
                    ]
                }
            };
        },
        methods: {
            init() {
                let userInfo = JSON.parse(Cookies.get("userInfo"));
                this.id = userInfo.id;
            },
            saveEditPass() {
                let params = {
                    id: this.id,
                    password: this.editPasswordForm.oldPass,
                    newPass: this.editPasswordForm.newPass
                };
                this.$refs["editPasswordForm"].validate(valid => {
                    if (valid) {
                        this.savePassLoading = true;
                        changePass(params).then(res => {
                            this.savePassLoading = false;
                            if (res.success === true) {
                                this.$Modal.success({
                                    title: "修改密码成功",
                                    content: "修改密码成功，需重新登录",
                                    onOk: () => {
                                        this.$store.commit("logout", this);
                                        this.$store.commit("clearOpenedSubmenu");
                                        this.$router.push({
                                            name: "login"
                                        });
                                    }
                                });
                            }
                        });
                    }
                });
            },
            cancelEditPass() {
                this.$store.commit("removeTag", "change_pass");
                localStorage.pageOpenedList = JSON.stringify(
                    this.$store.state.app.pageOpenedList
                );
                let lastPageName = "";
                if (this.$store.state.app.pageOpenedList.length > 1) {
                    lastPageName = this.$store.state.app.pageOpenedList[1].name;
                } else {
                    lastPageName = this.$store.state.app.pageOpenedList[0].name;
                }
                this.$router.push({
                    name: lastPageName
                });
            }
        },
        mounted() {
            this.init();
        }
    };
</script>
