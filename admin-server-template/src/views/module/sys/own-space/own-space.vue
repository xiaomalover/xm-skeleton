<style lang="less">
    @import "own-space.less";
</style>

<template>
    <div class="own-space">
        <Card>
            <Tabs>
                <TabPane label="基本信息" name="info">
                    <Form
                            ref="userForm"
                            :model="userForm"
                            :label-width="100"
                            label-position="right"
                    >
                        <FormItem label="用户头像：">
                            <span class="ivu-avatar ivu-avatar-circle ivu-avatar-large ivu-avatar-image"
                                  style="background: rgb(97, 159, 231); margin-left: 10px;"><img
                                    src="../../../../assets/avatar.png"></span>
                        </FormItem>
                        <FormItem label="用户账号：">
                            <span>{{userForm.username}}</span>
                        </FormItem>
                        <FormItem label="性别：">
                            <RadioGroup v-model="userForm.sex">
                                <Radio :label="1">男</Radio>
                                <Radio :label="0">女</Radio>
                            </RadioGroup>
                        </FormItem>
                        <FormItem label="手机号：">
                            <span>{{userForm.mobile}}</span>
                        </FormItem>
                        <FormItem label="邮箱：">
                            <span>{{userForm.email}}</span>
                        </FormItem>
                        <FormItem label="地址：">
                            <al-cascader v-model="userForm.addressArray" @on-change="changeAddress" data-type="code"
                                         level="2" style="width:250px"/>
                        </FormItem>
                        <FormItem label="所属部门：">
                            <span>{{ userForm.departmentTitle }}</span>
                        </FormItem>
                        <FormItem label="用户类型：">
                            <span>{{ userForm.typeTxt }}</span>
                        </FormItem>
                        <FormItem label="创建时间：">
                            <span>{{ userForm.createdAt }}</span>
                        </FormItem>
                        <FormItem>
                            <Button type="primary" style="width: 100px;margin-right:5px" :loading="saveLoading"
                                    @click="saveEdit">保存
                            </Button>
                            <Button @click="cancelEditUserInfo">取消</Button>
                        </FormItem>
                    </Form>
                </TabPane>
            </Tabs>

        </Card>
    </div>
</template>

<script>
    import {
        userInfoEdit,
    } from "@/api/index";
    import Cookies from "js-cookie";

    export default {
        name: "ownspace_index",
        data() {
            return {
                accessToken: {},
                userForm: {
                    id: "",
                    avatar: "",
                    username: "",
                    sex: "",
                    mobile: "",
                    email: "",
                    status: "",
                    type: "",
                    typeTxt: "",
                    address: "",
                    addressArray: []
                },
                codeError: "",
                initPhone: "",
                initEmail: "",
                uid: "", // 登录用户的userId
                saveLoading: false,
                savePassLoading: false,
                oldPassError: ""
            };
        },
        methods: {
            init() {
                this.accessToken = {
                    accessToken: this.getStore("accessToken")
                };
                let v = JSON.parse(Cookies.get("userInfo"));
                // 转换null为""
                for (let attr in v) {
                    if (v[attr] === null) {
                        v[attr] = "";
                    }
                }
                let str = JSON.stringify(v);
                let userInfo = JSON.parse(str);
                userInfo.addressArray = [];
                this.userForm = userInfo;
                this.initPhone = userInfo.mobile;
                this.initEmail = userInfo.email;
                if (userInfo.address !== null && userInfo.address !== "") {
                    this.userForm.address = userInfo.address;
                    this.userForm.addressArray = JSON.parse(userInfo.address);
                }
                if (this.userForm.type === 0) {
                    this.userForm.typeTxt = "普通用户";
                } else if (this.userForm.type === 1) {
                    this.userForm.typeTxt = "管理员";
                }
            },
            cancelEditUserInfo() {
                this.$store.commit("removeTag", "ownspace_index");
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
            },
            saveEdit() {
                this.saveLoading = true;
                let params = this.userForm;
                delete params.nickName;
                delete params.description;
                userInfoEdit(params).then(res => {
                    this.saveLoading = false;
                    if (res.success === true) {
                        this.$Message.success("保存成功");
                        // 更新用户信息
                        Cookies.set("userInfo", this.userForm);
                    }
                });
            },
            changeAddress() {
                this.userForm.address = JSON.stringify(this.userForm.addressArray);
            },
        },
        mounted() {
            this.init();
        }
    };
</script>
