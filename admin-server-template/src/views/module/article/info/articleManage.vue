<style lang="less">
    @import "articleManage.less";
</style>
<template>
    <div class="search">
        <Row>
            <Col>
                <Card>
                    <Row>
                        <Form ref="searchForm" :model="searchForm" inline :label-width="70" class="search-form">
                            <Form-item label="标题" prop="title">
                                <Input type="text" v-model="searchForm.title" clearable placeholder="请输入文章标题"
                                       style="width: 200px"/>
                            </Form-item>
                            <Form-item label="是否展示" prop="status">
                                <Select v-model="searchForm.status" placeholder="请选择是否展示" clearable
                                        style="width: 200px">
                                    <Option value="2">否</Option>
                                    <Option value="1">是</Option>
                                </Select>
                            </Form-item>

                            <Form-item label="创建时间">
                                <DatePicker v-model="selectDate" type="daterange" format="yyyy-MM-dd" clearable
                                    @on-change="selectDateRange" placeholder="选择起始时间"
                                    style="width: 200px"></DatePicker>
                            </Form-item>

                            <Form-item style="margin-left:-35px;" class="br">
                                <Button @click="handleSearch" type="primary" icon="ios-search">搜索</Button>
                                <Button @click="handleReset">重置</Button>
                            </Form-item>
                        </Form>
                    </Row>
                    <Row class="operation">
                        <Button @click="add" type="primary" icon="md-add">新增文章</Button>
                        <Button @click="delAll" icon="md-trash">批量删除</Button>
                        <Dropdown @on-click="handleDropdown">
                            <Button>
                                更多操作
                                <Icon type="md-arrow-dropdown"/>
                            </Button>
                            <DropdownMenu slot="list">
                                <DropdownItem name="refresh">刷新</DropdownItem>
                                <DropdownItem name="exportData">导出所选数据</DropdownItem>
                            </DropdownMenu>
                        </Dropdown>
                    </Row>
                    <Row>
                        <Alert show-icon>
                            已选择 <span class="select-count">{{selectCount}}</span> 项
                            <a class="select-clear" @click="clearSelectAll">清空</a>
                        </Alert>
                    </Row>
                    <Row>
                        <Table :loading="loading" border :columns="columns" :data="data" sortable="custom"
                               @on-sort-change="changeSort" @on-selection-change="showSelect" ref="table"></Table>
                        <Table :columns="columns" :data="exportData" ref="exportTable" style="display:none"></Table>
                    </Row>
                    <Row type="flex" justify="end" class="page">
                        <Page :current="searchForm.pageNumber" :total="total" :page-size="searchForm.pageSize"
                              @on-change="changePage" @on-page-size-change="changePageSize" :page-size-opts="[10,20,50]"
                              size="small" show-total show-elevator show-sizer></Page>
                    </Row>
                </Card>
            </Col>
        </Row>
        <Modal @on-visible-change="changeVisible" :fullscreen="fullscreen" :title="modalTitle"
               v-model="articleModalVisible" :mask-closable='false' width="1000px;">
            <Form ref="articleForm" :model="articleForm" :label-width="70" :rules="articleFormValidate">
                <FormItem label="文章标题" prop="title">
                    <Input v-model="articleForm.title" autocomplete="off" placeholder="请输入文章标题"/>
                </FormItem>
                <FormItem label="文章简介" prop="summary">
                    <Input v-model="articleForm.summary" type="textarea" placeholder="请输入公告简介..."/>
                </FormItem>
                <FormItem label="文章内容" prop="content">
                    <div id="editorElt" content="articleForm.content"></div>
                </FormItem>
                <FormItem label="作者" prop="author">
                    <Input v-model="articleForm.author" autocomplete="off" placeholder="请输入作者信息"/>
                </FormItem>
                <FormItem label="是否展示" prop="status">
                    <Select v-model="articleForm.status" placeholder="请选择是否要展示">
                        <Option :value="0">否</Option>
                        <Option :value="1">是</Option>
                    </Select>
                </FormItem>
            </Form>
            <div slot="footer">
                <i :title="fullscreen ? '关闭全屏' : '开启全屏'" @click="fullSc" class="ivu-icon ivu-icon-ios-expand"
                   style="font-size: 23px; float: left"></i>
                <Button type="text" @click="cancelArticle">取消</Button>
                <Button type="primary" :loading="submitLoading" @click="submitArticle">提交</Button>
            </div>
        </Modal>
    </div>
</template>

<script>

    import Editor from 'wangeditor';

    import {
        addArticle,
        deleteArticle,
        disableArticle,
        editArticle,
        enableArticle,
        getArticleListData,
        uploadCommon,
    } from "@/api/index";

    export default {
        name: "article-manage",
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
                selectList: [],
                imageBase: "",
                searchForm: {
                    title: "",
                    content: "",
                    status: null,
                    startDate: "",
                    endDate: "",
                    summary: "",
                },
                selectDate: null,
                modalType: 0,
                articleModalVisible: false,
                modalTitle: "",
                articleForm: {
                    title: "",
                    content: "",
                    author: "xm-skeleton",
                    summary: "",
                    status: null,
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
                columns: [
                    {
                        type: "selection",
                        width: 60,
                        align: "center",
                        fixed: "left"
                    },
                    {
                        type: "index",
                        width: 60,
                        align: "center",
                    },
                    {
                        title: "标题",
                        key: "title",
                        width: 350,
                        sortable: true,
                        align: "center",
                    },
                    {
                        title: "简介",
                        key: "summary",
                        sortable: true,
                        //width: 590,
                        align: "center",
                        type: "html",
                    },
                    {
                        title: "作者",
                        key: "author",
                        sortable: true,
                        //width: 590,
                        align: "center",
                    },
                    {
                        title: "是否展示",
                        key: "status",
                        width: 120,
                        align: "center",
                        render: (h, params) => {
                            let re = "";
                            if (params.row.status === 0) {
                                re = "否";
                            } else if (params.row.status === 1) {
                                re = "是";
                            }
                            return h("div", re);
                        },
                        filters: [
                            {
                                label: "是",
                                value: 1
                            },
                            {
                                label: "否",
                                value: 0
                            }
                        ],
                        filterMultiple: false,
                        filterMethod(value, row) {
                            if (value === 0) {
                                return row.status === 0;
                            } else if (value === 1) {
                                return row.status === 1;
                            }
                        }
                    },
                    {
                        title: "创建时间",
                        key: "createdAt",
                        sortable: true,
                        sortType: "desc",
                        width: 150,
                        render: (h, params) => {
                            return h("div", params.row.createdAt.replace(/.[0-9]*$/,''));
                        }
                    },
                    {
                        title: "操作",
                        key: "action",
                        width: 200,
                        align: "center",
                        fixed: "right",
                        render: (h, params) => {
                            if (params.row.status === 1) {
                                return h("div", [
                                    h(
                                        "Button",
                                        {
                                            props: {
                                                type: "primary",
                                                size: "small"
                                            },
                                            style: {
                                                marginRight: "5px"
                                            },
                                            on: {
                                                click: () => {
                                                    this.edit(params.row);
                                                }
                                            }
                                        },
                                        "编辑"
                                    ),
                                    h(
                                        "Button",
                                        {
                                            props: {
                                                size: "small"
                                            },
                                            style: {
                                                marginRight: "5px"
                                            },
                                            on: {
                                                click: () => {
                                                    this.disable(params.row);
                                                }
                                            }
                                        },
                                        "禁用"
                                    ),
                                    h(
                                        "Button",
                                        {
                                            props: {
                                                type: "error",
                                                size: "small"
                                            },
                                            on: {
                                                click: () => {
                                                    this.remove(params.row);
                                                }
                                            }
                                        },
                                        "删除"
                                    )
                                ]);
                            } else {
                                return h("div", [
                                    h(
                                        "Button",
                                        {
                                            props: {
                                                type: "primary",
                                                size: "small"
                                            },
                                            style: {
                                                marginRight: "5px"
                                            },
                                            on: {
                                                click: () => {
                                                    this.edit(params.row);
                                                }
                                            }
                                        },
                                        "编辑"
                                    ),
                                    h(
                                        "Button",
                                        {
                                            props: {
                                                type: "success",
                                                size: "small"
                                            },
                                            style: {
                                                marginRight: "5px"
                                            },
                                            on: {
                                                click: () => {
                                                    this.enable(params.row);
                                                }
                                            }
                                        },
                                        "启用"
                                    ),
                                    h(
                                        "Button",
                                        {
                                            props: {
                                                type: "error",
                                                size: "small"
                                            },
                                            on: {
                                                click: () => {
                                                    this.remove(params.row);
                                                }
                                            }
                                        },
                                        "删除"
                                    )
                                ]);
                            }
                        }
                    }
                ],
                data: [],
                exportData: [],
                total: 0
            };
        },
        methods: {
            //全屏切换
            fullSc() {
                this.fullscreen = !this.fullscreen;
            },
            //弹框发生变化时，关闭全屏
            changeVisible() {
                if (this.fullscreen === true) {
                    this.fullscreen = false;
                }
            },
            getImageBase() {

            },
            init() {
                this.accessToken = {
                    accessToken: this.getStore("accessToken")
                };
                this.getImageBase();
                this.getArticleList();
            },

            changePage(v) {
                this.searchForm.pageNumber = v;
                this.getArticleList();
                this.clearSelectAll();
            },
            changePageSize(v) {
                this.searchForm.pageSize = v;
                this.getArticleList();
            },
            selectDateRange(v) {
                if (v) {
                    this.searchForm.startDate = v[0];
                    this.searchForm.endDate = v[1];
                }
            },
            getArticleList() {
                // 多条件搜索配置列表
                this.loading = true;
                getArticleListData(this.searchForm).then(res => {
                    this.loading = false;
                    if (res.success === true) {
                        this.data = res.result.records;
                        this.total = res.result.total;
                    }
                });
            },
            handleSearch() {
                this.searchForm.pageNumber = 1;
                this.searchForm.pageSize = 10;
                this.getArticleList();
            },
            handleReset() {
                this.$refs.searchForm.resetFields();
                this.searchForm.pageNumber = 1;
                this.searchForm.pageSize = 10;
                this.selectDate = null;
                this.searchForm.startDate = "";
                this.searchForm.endDate = "";
                // 重新加载数据
                this.getArticleList();
            },
            changeSort(e) {
                this.searchForm.sort = e.key;
                this.searchForm.order = e.order;
                if (e.order === "normal") {
                    this.searchForm.order = "";
                }
                this.getArticleList();
            },

            handleDropdown(name) {
                if (name === "exportData") {
                    if (this.selectCount <= 0) {
                        this.$Message.warning("您还未选择要导出的数据");
                        return;
                    }
                    this.$Modal.confirm({
                        title: "确认导出",
                        content: "您确认要导出所选 " + this.selectCount + " 条数据?",
                        onOk: () => {
                            this.$refs.exportTable.exportCsv({
                                filename: "文章数据"
                            });
                        }
                    });
                } else if (name === "refresh") {
                    this.getArticleList();
                }
            },
            cancelArticle() {
                this.articleModalVisible = false;
            },
            submitArticle() {
                this.$refs.articleForm.validate(valid => {
                    if (valid) {
                        if (this.modalType === 0) {
                            // 添加文章 避免编辑后传入id
                            delete this.articleForm.status;
                            delete this.articleForm.artDate;
                            delete  this.articleForm.createdAt;
                            this.submitLoading = true;
                            addArticle(this.articleForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("操作成功");
                                    this.getArticleList();
                                    this.articleModalVisible = false;
                                }
                            });
                        } else {
                            // 编辑
                            editArticle(this.articleForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("操作成功");
                                    this.getArticleList();
                                    this.articleModalVisible = false;
                                }
                            });
                        }
                    }
                });
            },

            add() {
                this.modalType = 0;
                this.modalTitle = "添加文章";
                this.$refs.articleForm.resetFields();
                this.articleModalVisible = true;
                this.editor.txt.html('');
            },
            edit(v) {
                this.modalType = 1;
                this.modalTitle = "编辑文章";
                this.$refs.articleForm.resetFields();
                // 转换null为""
                for (let attr in v) {
                    if (v[attr] === null) {
                        v[attr] = "";
                    }
                }
                let str = JSON.stringify(v);
                let articleInfo = JSON.parse(str);
                this.articleForm = articleInfo;
                this.editor.txt.html(this.articleForm.content);
                this.articleModalVisible = true;
            },
            enable(v) {
                this.$Modal.confirm({
                    title: "确认启用",
                    content: "您确认要启用文章 " + v.title + " ?",
                    onOk: () => {
                        enableArticle(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("操作成功");
                                this.getArticleList();
                            }
                        });
                    }
                });
            },
            disable(v) {
                this.$Modal.confirm({
                    title: "确认禁用",
                    content: "您确认要禁用文章 " + v.title + " ?",
                    onOk: () => {
                        disableArticle(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("操作成功");
                                this.getArticleList();
                            }
                        });
                    }
                });
            },
            remove(v) {
                this.$Modal.confirm({
                    title: "确认删除",
                    content: "您确认要删除文章 " + v.title + " ?",
                    onOk: () => {
                        deleteArticle(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("删除成功");
                                this.getArticleList();
                            }
                        });
                    }
                });
            },
            dropDown() {
                if (this.drop) {
                    this.dropDownContent = "展开";
                    this.dropDownIcon = "ios-arrow-down";
                } else {
                    this.dropDownContent = "收起";
                    this.dropDownIcon = "ios-arrow-up";
                }
                this.drop = !this.drop;
            },
            showSelect(e) {
                this.exportData = e;
                this.selectList = e;
                this.selectCount = e.length;
            },
            clearSelectAll() {
                this.$refs.table.selectAll(false);
            },
            delAll() {
                if (this.selectCount <= 0) {
                    this.$Message.warning("您还未选择要删除的数据");
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
                        deleteArticle(ids).then(res => {
                            if (res.success === true) {
                                this.$Message.success("删除成功");
                                this.clearSelectAll();
                                this.getArticleList();
                            }
                        });
                    }
                });
            },
            async initEditor() {
                this.editor = new Editor('#editorElt');
                /* 括号里面的对应的是html里div的id */
                /* 配置菜单栏 */
                this.editor.customConfig.menu = [
                    'head',  // 标题
                    'bold',  // 粗体
                    'fontSize',  // 字号
                    'fontName',  // 字体
                    'italic',  // 斜体
                    'underline',  // 下划线
                    'strikeThrough',  // 删除线
                    'foreColor',  // 文字颜色
                    'backColor',  // 背景颜色
                    'link',  // 插入链接
                    'list',  // 列表
                    'justify',  // 对齐方式
                    'quote',  // 引用
                    'emoticon',  // 表情
                    'image',  // 插入图片
                    'table',  // 表格
                    'code',  // 插入代码
                    'undo',  // 撤销
                    'redo'  // 重复
                ];
                this.editor.customConfig.uploadImgMaxLength = 5;
                /*限制一次最多上传 5 张图片 */
                this.editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024;
                /* 将图片大小限制为 3M 默认为5M /
                               /* 自定义图片上传（支持跨域和非跨域上传，简单操作）*/
                this.editor.customConfig.customUploadImg = async (files, insert) => {
                    /* files 是 input 中选中的文件列表 */
                    let formData = new FormData();
                    formData.append('file', files[0]);
                    formData.append('folder', 'article');
                    uploadCommon(formData).then(res => {
                        if (res.success === true) {
                            insert(res.result.fullUrl);
                        }
                    });
                };
                this.editor.customConfig.onchange = (html) => {
                    this.articleForm.content = html;
                };
                this.editor.create()
                /* 创建编辑器 */
            }
        },
        mounted() {
            this.init();
            this.initEditor();
        }
    };
</script>
