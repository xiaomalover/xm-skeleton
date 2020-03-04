<style lang="less">
    @import "categoryManage.less";
</style>
<template>
    <div class="search">
        <Card>
            <Row class="operation">
                <Button @click="add" type="primary" icon="md-add" v-has="'add'">添加子分类</Button>
                <Button @click="addRoot" icon="md-add" v-has="'add'">添加一级分类</Button>
                <Button @click="delAll" icon="md-trash" v-has="'delete'">批量删除</Button>
                <Button @click="getParentList" icon="md-refresh">刷新</Button>
            </Row>
            <Row type="flex" justify="start" class="code-row-bg">
                <Col span="6">
                    <Alert show-icon>
                        当前选择编辑： <span class="select-count">{{editTitle}}</span>
                        <a class="select-clear" v-if="form.id" @click="canelEdit">取消选择</a>
                    </Alert>
                    <Tree :data="data" :load-data="loadData" show-checkbox @on-check-change="changeSelect"
                          @on-select-change="selectTree"></Tree>
                    <Spin size="large" fix v-if="loading"></Spin>
                </Col>
                <Col span="9">
                    <Form ref="form" :model="form" :label-width="85" :rules="menuFormValidate">
                        <FormItem label="上级分类" prop="parentTitle">
                            <Poptip trigger="click" placement="right-start" title="选择上级分类" width="250">
                                <Input v-model="form.parentTitle" readonly/>
                                <div slot="content" style="position:relative;min-height:5vh">
                                    <Tree :data="dataEdit" :load-data="loadData"
                                          @on-select-change="selectTreeEdit"></Tree>
                                    <Spin size="large" fix v-if="loadingEdit"></Spin>
                                </div>
                            </Poptip>
                        </FormItem>
                        <FormItem label="分类名称" prop="title">
                            <Input v-model="form.title"/>
                        </FormItem>
                        <FormItem label="分类短名称" prop="shortTitle">
                            <Input v-model="form.shortTitle"/>
                        </FormItem>
                        <FormItem label="排序值" prop="sortNo">
                            <InputNumber :max="1000" :min="0" v-model="form.sortNo"></InputNumber>
                            <span style="margin-left:5px">值越小越靠前，支持小数</span>
                        </FormItem>
                        <FormItem label="是否启用" prop="status">
                            <i-switch size="large" v-model="editStatus" @on-change="changeEditSwitch">
                                <span slot="open">启用</span>
                                <span slot="close">禁用</span>
                            </i-switch>
                        </FormItem>
                        <Form-item>
                            <Button @click="submitEdit" :loading="submitLoading" type="primary"
                                    icon="ios-create-outline" v-has="'edit'">修改并保存
                            </Button>
                            <Button @click="handleReset" v-has="'edit'">重置</Button>
                        </Form-item>
                    </Form>
                </Col>
            </Row>
        </Card>

        <Modal :title="modalTitle" v-model="menuModalVisible" :mask-closable='false' :width="500">
            <Form ref="formAdd" :model="formAdd" :label-width="85" :rules="menuFormValidate">
                <div v-if="showParent">
                    <FormItem label="上级分类：">
                        {{form.title}}
                    </FormItem>
                </div>
                <FormItem label="分类名称" prop="title">
                    <Input v-model="formAdd.title"/>
                </FormItem>
                <FormItem label="分类短名称" prop="shortTitle">
                    <Input v-model="formAdd.shortTitle"/>
                </FormItem>
                <FormItem label="排序值" prop="sortNo">
                    <InputNumber :max="1000" :min="0" v-model="formAdd.sortNo"></InputNumber>
                    <span style="margin-left:5px">值越小越靠前，支持小数</span>
                </FormItem>
                <FormItem label="是否启用" prop="status">
                    <i-switch size="large" v-model="addStatus" @on-change="changeAddSwitch">
                        <span slot="open">启用</span>
                        <span slot="close">禁用</span>
                    </i-switch>
                </FormItem>
            </Form>
            <div slot="footer">
                <Button type="text" @click="cancelAdd">取消</Button>
                <Button v-has="'add'" type="primary" :loading="submitLoading" @click="submitAdd">提交</Button>
            </div>
        </Modal>
    </div>
</template>

<script>
    import {
        initArticleCategory,
        loadArticleCategory,
        addArticleCategory,
        editArticleCategory,
        deleteArticleCategory
    } from "@/api/index";

    export default {
        name: "articleCategory-manage",
        data() {
            return {
                loading: true,
                loadingEdit: true,
                menuModalVisible: false,
                selectList: [],
                selectCount: 0,
                showParent: false,
                editStatus: true,
                addStatus: true,
                modalTitle: "",
                editTitle: "",
                form: {
                    id: "",
                    parentId: "",
                    parentTitle: "",
                    sortNo: null,
                    status: 1,
                    url: "",
                },
                formAdd: {},
                menuFormValidate: {
                    title: [{required: true, message: "名称不能为空", trigger: "blur"}],
                    shortTitle: [{required: true, message: "短名称不能为空", trigger: "blur"}]
                },
                submitLoading: false,
                data: [],
                dataEdit: []
            };
        },
        methods: {
            init() {
                this.getParentList();
                this.getParentListEdit();
            },
            getParentList() {
                this.loading = true;
                initArticleCategory().then(res => {
                    this.loading = false;
                    if (res.success === true) {
                        res.result.forEach(function (e) {
                            if (e.isParent) {
                                e.loading = false;
                                e.children = [];
                            }
                        });
                        this.data = res.result;
                    }
                });
            },
            getParentListEdit() {
                this.loadingEdit = true;
                initArticleCategory().then(res => {
                    this.loadingEdit = false;
                    if (res.success === true) {
                        res.result.forEach(function (e) {
                            if (e.isParent) {
                                e.loading = false;
                                e.children = [];
                            }
                        });
                        // 头部加入一级
                        let first = {
                            id: "0",
                            title: "一级分类"
                        };
                        res.result.unshift(first);
                        this.dataEdit = res.result;
                    }
                });
            },
            loadData(item, callback) {
                loadArticleCategory(item.id).then(res => {
                    if (res.success === true) {
                        res.result.forEach(function (e) {
                            if (e.isParent) {
                                e.loading = false;
                                e.children = [];
                            }
                        });
                        callback(res.result);
                    }
                });
            },
            selectTree(v) {
                if (v.length > 0) {

                    if (Number(v[0].status) === 1) {
                        this.editStatus = true;
                    } else {
                        this.editStatus = false;
                    }
                    // 转换null为""
                    for (let attr in v[0]) {
                        if (v[0][attr] === null) {
                            v[0][attr] = "";
                        }
                    }
                    let str = JSON.stringify(v[0]);
                    let data = JSON.parse(str);
                    data.sortNo = data.sortNo - 0;
                    this.form = data;
                    this.editTitle = data.title;
                }
            },
            canelEdit() {
                this.isMenu = false;
                this.isButton = false;
                this.$refs.form.resetFields();
                delete this.form.id;
                this.editTitle = "";
            },
            selectTreeEdit(v) {
                if (v.length > 0) {
                    // 转换null为""
                    for (let attr in v[0]) {
                        if (v[0][attr] === null) {
                            v[0][attr] = "";
                        }
                    }
                    let str = JSON.stringify(v[0]);
                    let data = JSON.parse(str);
                    this.form.parentId = data.id;
                    this.form.parentTitle = data.title;
                }
            },
            cancelAdd() {
                this.menuModalVisible = false;
            },
            handleReset() {
                this.$refs.form.resetFields();
                this.editStatus = true;
                this.form.status = 1;
            },
            changeEditSwitch(v) {
                if (v) {
                    this.form.status = 1;
                } else {
                    this.form.status = 0;
                }
            },
            submitEdit() {
                this.$refs.form.validate(valid => {
                    if (valid) {
                        if (!this.form.id) {
                            this.$Message.warning("请先点击选择要修改的分类");
                            return;
                        }
                        this.submitLoading = true;
                        if (this.form.sortNo === null) {
                            this.form.sortNo = "";
                        }
                        if (this.form.buttonType === null) {
                            this.form.buttonType = "";
                        }
                        editArticleCategory(this.form).then(res => {
                            this.submitLoading = false;
                            if (res.success === true) {
                                this.$Message.success("编辑成功");
                                this.init();
                                this.menuModalVisible = false;
                            }
                        });
                    }
                });
            },
            changeAddSwitch(v) {
                if (v) {
                    this.formAdd.status = 1;
                } else {
                    this.formAdd.status = 0;
                }
            },
            submitAdd() {
                this.$refs.formAdd.validate(valid => {
                    if (valid) {
                        this.submitLoading = true;
                        if (this.formAdd.sortNo === null) {
                            this.formAdd.sortNo = "";
                        }
                        if (this.formAdd.buttonType === null) {
                            this.formAdd.buttonType = "";
                        }
                        addArticleCategory(this.formAdd).then(res => {
                            this.submitLoading = false;
                            if (res.success === true) {
                                this.$Message.success("添加成功");
                                this.init();
                                this.menuModalVisible = false;
                            }
                        });
                    }
                });
            },
            add() {
                if (this.form.id == "" || this.form.id == null) {
                    this.$Message.warning("请先点击选择一个分类");
                    return;
                }
                this.modalTitle = "添加子分类";
                this.showParent = true;
                this.formAdd = {
                    parentId: this.form.id,
                    sortNo: 1,
                    status: 1
                };
                this.menuModalVisible = true;
            },
            addRoot() {
                this.modalTitle = "添加一级分类";
                this.showParent = false;
                this.formAdd = {
                    parentId: 0,
                    sortNo: 1,
                    status: 1
                };
                this.menuModalVisible = true;
            },
            changeSelect(v) {
                this.selectCount = v.length;
                this.selectList = v;
            },
            delAll() {
                if (this.selectCount <= 0) {
                    this.$Message.warning("您还未勾选要删除的数据");
                    return;
                }
                this.$Modal.confirm({
                    title: "确认删除",
                    content: "您确认要删除所选的 " + this.selectCount + " 条数据?",
                    onOk: () => {
                        let ids = "";
                        this.selectList.forEach(function (e) {
                            ids += e.id + ",";
                        });
                        ids = ids.substring(0, ids.length - 1);
                        deleteArticleCategory(ids).then(res => {
                            if (res.success === true) {
                                this.$Message.success("删除成功");
                                this.selectList = [];
                                this.selectCount = 0;
                                this.canelEdit();
                                this.init();
                            }
                        });
                    }
                });
            }
        },
        mounted() {
            this.init();
        }
    };
</script>