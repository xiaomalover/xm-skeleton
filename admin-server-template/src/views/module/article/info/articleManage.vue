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
                                    <Option value="0">否</Option>
                                    <Option value="1">是</Option>
                                </Select>
                            </Form-item>

                            <Form-item label="分类" prop="category">
                                <Cascader v-model="selectDep" :data="category" :load-data="loadData"
                                          @on-change="handleChangeDep" change-on-select filterable
                                          placeholder="请选择或输入搜索分类" style="width: 200px"></Cascader>
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
                        <Button @click="add" type="primary" icon="md-add" v-has="'add'">新增文章</Button>
                        <Button @click="delAll" icon="md-trash" v-has="'delete'">批量删除</Button>
                        <Dropdown @on-click="handleDropdown">
                            <Button>
                                更多操作
                                <Icon type="md-arrow-dropdown"/>
                            </Button>
                            <DropdownMenu slot="list">
                                <DropdownItem name="refresh">刷新</DropdownItem>
                                <DropdownItem name="exportData">导出所选数据</DropdownItem>
                                <DropdownItem name="exportDataAll">导出全部数据</DropdownItem>
                            </DropdownMenu>
                        </Dropdown>

                        <Dropdown @on-click="handleDropdown" style="float:right">
                            <Button>
                                设置显示列
                                <Icon type="md-arrow-dropdown"/>
                            </Button>
                            <DropdownMenu slot="list" style="padding: 10px;">
                                <Checkbox-group v-model="tableColumnsChecked" @on-change="changeTableColumns">
                                    <Checkbox v-for="(item) in allColumns" :label="item.key" :key="item.key">{{item.title}}</Checkbox>
                                </Checkbox-group>
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
                        <Table :columns="allColumns" :data="exportData" ref="exportTable" style="display:none"></Table>
                    </Row>
                    <Row type="flex" justify="end" class="page">
                        <Page :current="searchForm.pageNumber" :total="total" :page-size="searchForm.pageSize"
                              @on-change="changePage" @on-page-size-change="changePageSize" :page-size-opts="[10,20,50]"
                              size="small" show-total show-elevator show-sizer></Page>
                    </Row>
                </Card>
            </Col>
        </Row>
    </div>
</template>

<script>
    import Cookies from "js-cookie";
    import {
        deleteArticle,
        disableArticle,
        enableArticle,
        getArticleListData,
        loadArticleCategory,
        getUploadDomain,
    } from "@/api/index";
    import moment from 'moment';

    export default {
        name: "article-manage",
        data() {
            return {
                accessToken: {},
                loading: true,
                drop: false,
                dropDownContent: "展开",
                dropDownIcon: "ios-arrow-down",
                selectCount: 0,
                imageDomain: "",
                selectList: [],
                category: [],
                selectDep: [],
                permTypes: [],
                tableColumnsChecked: ['thumb', 'title', 'categoryTitle', 'status', 'createdAt'],
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
                columns: [],
                allColumns: [
                    {
                        title: "缩略图",
                        key: "thumb",
                        align: "center",
                        render: (h, params) => {
                            if (params.row.thumb) {
                                return h('div', {
                                    attrs: {
                                        style: ''
                                    },
                                }, [
                                    h('img', {
                                        props: {
                                            type: 'primary',
                                            size: 'small'
                                        },
                                        attrs: {
                                            src: this.imageDomain + params.row.thumb,
                                            style: 'width: 90px;height: 90px;border-radius: 2px;'
                                        },
                                        style: "text-align:center;margin:3px auto;",
                                    }),
                                ]);
                            } else {
                                return h('div', '-');
                            }
                        }
                    },
                    {
                        title: "标题",
                        key: "title",
                        sortable: true,
                        align: "center",
                    },
                    {
                        title: "简介",
                        key: "summary",
                        sortable: true,
                        align: "center",
                        type: "html",
                    },
                    {
                        title: "分类",
                        key: "categoryTitle",
                        align: "center",
                        render: (h, params) => {
                            if (params.row.categoryTitle === "") {
                                return h('div', '-');
                            } else {
                                return h('div', params.row.categoryTitle);
                            }
                        }
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
                        render: (h, params) => {
                            return h("div", moment(params.row.createdAt * 1000).format('YYYY-MM-DD HH:mm:ss'));
                        }
                    },
                ],
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
                this.changeTableColumns();
                this.$refs.ueditor = {};
                this.getImageBase();
                this.initMeta();
                this.initCategoryData();
                this.getArticleList();
            },

            initMeta() {
                let permTypes = this.$route.meta.permTypes;
                if (permTypes !== null && permTypes !== undefined) {
                    this.permTypes = permTypes;
                }
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
                this.selectCount = 0;
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
            handleSearchExportAll() {
                let str = JSON.stringify(this.searchForm);
                let params = JSON.parse(str);
                params.pageNumber = 1;
                params.pageSize = 1000000000;
                // 多条件搜索配置列表
                getArticleListData(params).then(res => {
                    if (res.success === true) {
                        this.exportData = res.result.records;
                    }
                });
            },
            handleReset() {
                this.$refs.searchForm.resetFields();
                this.searchForm.pageNumber = 1;
                this.searchForm.pageSize = 10;
                this.selectDate = null;
                this.searchForm.startDate = "";
                this.searchForm.endDate = "";
                this.searchForm.categoryId = "";
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
                                filename: "文章数据",
                                columns: this.allColumns.filter((col, index) => index  >  0),
                                data: this.exportData.map(item =>{
                                    item.createdAt = moment(item.createdAt * 1000).format('YYYY-MM-DD HH:mm:ss');

                                    if (item.status === 0) {
                                        item.status = "否";
                                    } else if (item.status === 1) {
                                        item.status = "是";
                                    }

                                    return item;
                                }),
                            });
                        }
                    });
                } else if (name === "exportDataAll") {

                    this.handleSearchExportAll();

                    this.$Modal.confirm({
                        title: "确认导出",
                        content: "您确认要导出全部数据?",
                        onOk: () => {

                            if (this.exportData.length <= 0) {
                                this.$Message.warning("没有数据需要导出");
                                return;
                            }

                            this.$refs.exportTable.exportCsv({
                                filename: "文章数据",
                                columns: this.allColumns.filter((col, index) => index  >  0),
                                data: this.exportData.map(item =>{
                                    item.createdAt = moment(item.createdAt * 1000).format('YYYY-MM-DD HH:mm:ss');

                                    if (item.status === 0) {
                                        item.status = "否";
                                    } else if (item.status === 1) {
                                        item.status = "是";
                                    }

                                    return item;
                                }),
                            });
                        }
                    });
                } else if (name === "refresh") {
                    this.getArticleList();
                }
            },

            add() {
                this.$router.push({
                    name: 'article_edit',
                    query: {type: 'add'},
                })
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

            initCategoryData() {
                loadArticleCategory(0).then(res => {
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
                        this.deleteDisableNode(res.result);
                        this.category = res.result;
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
                        this.deleteDisableNode(res.result);
                        item.children = res.result;
                        callback();
                    }
                });
            },

            loadDataTree(item, callback) {
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

            changeTableColumns() {
                this.columns = this.getTableColumns();
            },

            getTableColumns() {
                let checkedColumns = [];

                //加入前面的复选框，这是必展示的
                let selectionColumn = {
                    type: "selection",
                    align: "center",
                    fixed: "left"
                };
                checkedColumns.push(selectionColumn);

                //后面加入操作按键，这是必展示的
                let operateColumn = {
                    title: "操作",
                    key: "action",
                    align: "center",
                    fixed: "right",
                    render: (h, params) => {
                        let editBtn; let disableBtn; let enableBtn; let deleteBtn;

                        if (this.permTypes.includes("edit")) {
                            editBtn = h(
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
                                            let articleId = params.row.id;
                                            this.$router.push({
                                                name: 'article_edit',
                                                query: {type: 'edit', id: articleId},
                                            })
                                        }
                                    }
                                },
                                "编辑"
                            );
                        }

                        if (this.permTypes.includes("enable")) {
                            enableBtn = h(
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
                            );
                        }

                        if (this.permTypes.includes("disable")) {
                            disableBtn = h(
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
                            );
                        }

                        if (this.permTypes.includes("delete")) {
                            deleteBtn = h(
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
                            );
                        }

                        if (params.row.status === 1) {
                            return h("div", [
                                editBtn,
                                disableBtn,
                                deleteBtn
                            ]);
                        } else {
                            return h("div", [
                                editBtn,
                                enableBtn,
                                deleteBtn
                            ]);
                        }
                    }
                };

                let that = this;
                this.allColumns.forEach(function (c) {
                    that.tableColumnsChecked.forEach(function (e) {
                        if (c.key === e) {
                            checkedColumns.push(c);
                        }
                    })
                });

                checkedColumns.push(operateColumn);

                return checkedColumns;
            },
        },

        mounted() {
            this.init();
        }
    };
</script>
