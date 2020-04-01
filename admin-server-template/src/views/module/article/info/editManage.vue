<style lang="less">
    @import "articleManage.less";
</style>
<template>
    <div>

        <Card>
            <Form ref="articleForm" :model="articleForm" :label-width="70" :rules="articleFormValidate">
                <FormItem label="文章标题" prop="title">
                    <Input v-model="articleForm.title" autocomplete="off" placeholder="请输入文章标题"/>
                </FormItem>
                <FormItem label="缩略图">
                    <div class="upload-list" v-for="item in uploadList" :key="item.url">
                        <template v-if="item.status === 'finished'">
                            <img v-if="item.url" :src="item.url" style="width: 100px; height: 100px;">
                            <div :class="{optEnable:operateEnable, optDisable:operateDisable}">
                                <Icon type="ios-eye-outline" @click.native="handleView(item.url)"></Icon>
                                <Icon type="ios-trash-outline" @click.native="handleRemove(item)"></Icon>
                            </div>
                        </template>
                        <template v-else>
                            <Progress v-if="item.showProgress" :percent="item.percentage" hide-info></Progress>
                        </template>
                    </div>
                    <Upload
                            :class="{uploadBtnDisabled:uploadDisabled, uploadBtnEnable:uploadEnable}"
                            ref="upload"
                            :show-upload-list="false"
                            :default-file-list="defaultList"
                            :on-success="handleSuccess"
                            :on-error="handleError"
                            :format="['jpg','jpeg','png','gif']"
                            :max-size="5120"
                            :multiple="false"
                            :on-format-error="handleFormatError"
                            :on-exceeded-size="handleMaxSize"
                            type="drag"
                            :action="uploadFileUrl"
                            :headers="accessToken">
                        <div style="width: 58px;height:58px;line-height: 58px;">
                            <Icon type="md-add" size="20"></Icon>
                        </div>
                    </Upload>
                </FormItem>
                <FormItem label="文章简介" prop="summary">
                    <Input v-model="articleForm.summary" type="textarea" placeholder="请输入公告简介..."/>
                </FormItem>
                <FormItem label="文章内容" prop="content">
                    <vue-ueditor-wrap ref="ueditor" v-model="articleForm.content" :destroy="true" :config="config" style="line-height: 20px;"></vue-ueditor-wrap>
                </FormItem>
                <FormItem label="作者" prop="author">
                    <Input v-model="articleForm.author" autocomplete="off" placeholder="请输入作者信息"/>
                </FormItem>
                <Form-item label="所属分类" prop="categoryTitle">
                    <Poptip trigger="click" placement="bottom-start" title="选择分类">
                        <div style="display:flex;">
                            <Input v-model="articleForm.categoryTitle" readonly style="margin-right:10px;"/>
                            <Button icon="md-trash" @click="clearSelectDep">清空已选</Button>
                        </div>
                        <div slot="content">
                            <Tree :data="dataDep" :load-data="loadDataTree" @on-select-change="selectTree"></Tree>
                            <Spin size="large" fix v-if="loading"></Spin>
                        </div>
                    </Poptip>
                </Form-item>
                <FormItem label="是否展示" prop="status">
                    <Select v-model="articleForm.status" placeholder="请选择是否要展示">
                        <Option :value="0">否</Option>
                        <Option :value="1">是</Option>
                    </Select>
                </FormItem>

                <FormItem>
                    <Button type="default" @click="cancelArticle">返回列表</Button>
                    <Button type="primary" :loading="submitLoading" @click="submitArticle" style="float:right;">提交</Button>
                </FormItem>
            </Form>

        </Card>

        <Modal title="图片预览" v-model="viewImage" draggable>
            <img :src="imgUrl" style="width: 80%;margin: 0 auto;display: block;">
            <div slot="footer">
                <Button @click="viewImage=false">关闭</Button>
            </div>
        </Modal>
    </div>
</template>

<script>

    import VueUeditorWrap from 'vue-ueditor-wrap'
    import Cookies from "js-cookie";

    import {
        addArticle,
        editArticle,
        loadArticleCategory,
        uploadArticleThumb,
        getUploadDomain,
        getArticle,
    } from "@/api/index";

    export default {
        name: "edit-manage",
        components: {
            VueUeditorWrap
        },
        data() {
            return {
                accessToken: {},
                loading: true,
                editor: '',
                drop: false,
                fullscreen: false,
                dropDownContent: "展开",
                dropDownIcon: "ios-arrow-down",
                selectCount: 0,
                imageDomain: "",
                actionType: "",
                articleId: "",
                defaultList: [
                    {
                        url: ""
                    }
                ],
                config: {
                    // 编辑器不自动被内容撑高
                    autoHeightEnabled: false,
                    // 初始容器高度
                    initialFrameHeight: 240,
                    // 初始容器宽度
                    initialFrameWidth: '100%',
                    serverUrl: window.location.protocol + "//" + window.location.host + "/skeleton/ueditor/exec",
                    // UEditor 资源文件的存放路径，如果你使用的是 vue-cli 生成的项目，通常不需要设置该选项，vue-ueditor-wrap 会自动处理常见的情况，如果需要特殊配置，参考下方的常见问题2
                    UEDITOR_HOME_URL: 'ueditor/',
                    // 配合最新编译的资源文件，你可以实现添加自定义Request Headers,详情https://github.com/HaoChuan9421/ueditor/commits/dev-1.4.3.3
                    headers: {
                        accessToken: this.getStore("accessToken")
                    }
                },
                imgUrl: "",
                uploadList: [],
                viewImage: false,
                uploadFileUrl: uploadArticleThumb,
                selectList: [],
                selectDep: [],
                dataDep: [],
                selectDate: null,
                modalType: 0,
                modalTitle: "",
                articleForm: {
                    title: "",
                    content: "",
                    author: "XM 团队",
                    summary: "",
                    categoryTitle: "",
                    status: null,
                    thumb: "",
                },

                articleFormValidate: {
                    title: [
                        {required: true, message: "标题不能为空"}
                    ],
                    status: [
                        {required: true, message: "请选择是否展示"}
                    ],
                    content: [
                        {required: true, message: "内容不能为空", trigger: "blur"}
                    ],
                },
                submitLoading: false,
                data: [],
                exportData: [],
                total: 0
            };
        },
        methods: {
            init() {
                this.accessToken = {
                    accessToken: this.getStore("accessToken")
                };
                this.getImageBase();
                this.uploadList = this.$refs.upload.fileList;
                this.getParentList();
                this.actionType = this.$route.query.type;
                if (this.actionType === "edit") {
                    this.articleId = this.$route.query.id;
                    this.getArticleDetail();
                }
            },

            getArticleDetail() {
                // 多条件搜索配置列表
                this.loading = true;
                getArticle(this.articleId).then(res => {
                    this.loading = false;
                    if (res.success === true) {
                        this.$refs.articleForm.resetFields();
                        let str = JSON.stringify(res.result);
                        let articleInfo = JSON.parse(str);
                        this.articleForm = articleInfo;
                        this.defaultList[0].url = this.articleForm.thumb !== "" ? this.imageDomain + this.articleForm.thumb : "";
                        this.uploadList = this.articleForm.thumb !== "" ? this.defaultList : [];
                    }
                });
            },

            cancelArticle() {
                this.$router.push({path: '/article/module/article/info'});
            },
            submitArticle() {
                this.$refs.articleForm.validate(valid => {
                    if (valid) {
                        if (this.actionType === "add") {
                            // 添加文章 避免编辑后传入id
                            delete this.articleForm.id;
                            this.submitLoading = true;
                            addArticle(this.articleForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("添加成功");
                                    this.$router.push({path: '/article/module/article/info'});
                                }
                            });
                        } else {
                            // 编辑
                            editArticle(this.articleForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("修改成功");
                                    this.$router.push({path: '/article/module/article/info'});
                                }
                            });
                        }
                    }
                });
            },
            getParentList() {
                loadArticleCategory(0).then(res => {
                    if (res.success === true) {
                        this.loading = false;
                        res.result.forEach(function (e) {
                            if (e.isParent) {
                                e.loading = false;
                                e.children = [];
                            }
                        });
                        this.deleteDisableNode(res.result);
                        this.dataDep = res.result;
                    }
                });
            },

            // 递归标记禁用节点
            deleteDisableNode(permData) {
                let that = this;
                permData.forEach(function (e) {
                    if (e.status === 0) {
                        e.title = "[已禁用] " + e.title;
                        e.disabled = true;
                    }
                    if (e.children && e.children.length > 0) {
                        that.deleteDisableNode(e.children);
                    }
                });
            },

            loadData(item, callback) {
                item.loading = true;
                loadArticleCategory(item.value).then(res => {
                    item.loading = false;
                    if (res.success === true) {
                        res.result.forEach(function (e) {
                            if (e.isParent) {
                                e.value = e.id;
                                e.label = e.title;
                                e.loading = false;
                                e.children = [];
                            } else {
                                e.value = e.id;
                                e.label = e.title;
                            }
                        });
                        deleteDisableNode(res.result);
                        item.children = res.result;
                        callback();
                    }
                });
            },

            loadDataTree(item, callback) {
                item.loading = true;
                loadArticleCategory(item.id).then(res => {
                    if (res.success === true) {
                        res.result.forEach(function (e) {
                            if (e.isParent) {
                                e.loading = false;
                                e.children = [];
                            }
                        });
                        this.deleteDisableNode(res.result);
                        callback(res.result);
                    }
                });
            },

            selectTree(v) {
                if (v.length > 0) {
                    // 转换null为""
                    for (let attr in v[0]) {
                        if (v[0][attr] === null) {
                            v[0][attr] = "";
                        }
                    }
                    let str = JSON.stringify(v[0]);
                    let data = JSON.parse(str);
                    this.articleForm.categoryId = data.id;
                    this.articleForm.categoryTitle = data.title;
                }
            },

            clearSelectDep() {
                this.articleForm.categoryId = "";
                this.articleForm.categoryTitle = "";
            },

            handleChangeDep(value, selectedData) {
                // 获取最后一个值
                if (value && value.length > 0) {
                    this.searchForm.categoryId = value[value.length - 1];
                } else {
                    this.searchForm.categoryId = "";
                }
            },

            handleChangeUserFormDep(value, selectedData) {
                // 获取最后一个值
                if (value && value.length > 0) {
                    this.articleForm.categoryId = value[value.length - 1];
                } else {
                    this.articleForm.categoryId = "";
                }
            },

            handleView(imgUrl) {
                this.imgUrl = imgUrl;
                this.viewImage = true;
            },

            handleRemove(file) {
                const fileList = this.$refs.upload.fileList;
                this.articleForm.thumb = "";
                this.$refs.upload.fileList.splice(fileList.indexOf(file), 1);
                this.defaultList[0].url = "";
                this.uploadList = [];
            },

            handleSuccess(res, file) {
                if (res.success === true) {
                    file.url = res.result.fullUrl;
                    this.articleForm.thumb = res.result.relative;
                    this.defaultList[0].url = res.result.fullUrl;
                    this.uploadList = this.defaultList;
                } else {
                    this.$Message.error(res.message);
                }
            },

            handleError(error, file, fileList) {
                this.$Message.error(error.toString());
            },

            handleFormatError(file) {
                this.$Notice.warning({
                    title: "不支持的文件格式",
                    desc:
                    "所选文件‘ " +
                    file.name +
                    " ’格式不正确, 请选择 .jpg .jpeg .png .gif格式文件"
                });
            },

            handleMaxSize(file) {
                this.$Notice.warning({
                    title: "文件大小过大",
                    desc: "所选文件‘ " + file.name + " ’大小过大, 不得超过 5M."
                });
            },

            getImageBase() {
                if(Cookies.get("imageDomain")) {
                    this.imageDomain = Cookies.get("imageDomain");
                } else {
                    // 多条件搜索配置列表
                    this.loading = true;
                    getUploadDomain().then(res => {
                        this.loading = false;
                        if (res.success === true) {
                            this.imageDomain = res.result;
                            Cookies.set("imageDomain", this.imageDomain);
                        }
                    });
                }
            },
        },

        computed: {

            uploadDisabled:function() {
                return this.defaultList[0].url !== "";
            },

            uploadEnable:function() {
                return this.defaultList[0].url === "";
            },
            operateEnable:function() {
                return this.defaultList[0].url !== "";
            },
            operateDisable:function() {
                return this.defaultList[0].url === "";
            }
        },

        beforeDestroy() {
            if (this.$refs.ueditor) {
                this.$refs.ueditor.$destroy();
                this.$refs.ueditor = {};
            }
        },

        mounted() {
            this.init();
        }
    };
</script>
