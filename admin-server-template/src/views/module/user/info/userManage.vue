<style lang="less">
    @import "userManage.less";
</style>
<template>
    <div class="search">
        <Row>
            <Col>
                <Card>
                    <Row>
                        <Form ref="searchForm" :model="searchForm" inline :label-width="70" class="search-form">
                            <Form-item label="用户名" prop="username">
                                <Input type="text" v-model="searchForm.username" clearable placeholder="请输入用户名"
                                       style="width: 200px"/>
                            </Form-item>
                            <Form-item label="手机号" prop="mobile">
                                <Input type="text" v-model="searchForm.mobile" clearable placeholder="请输入手机号"
                                       style="width: 200px"/>
                            </Form-item>
                            <Form-item label="用户状态" prop="status">
                                <Select v-model="searchForm.status" placeholder="请选择状态" clearable
                                        style="width: 200px">
                                    <Option value="0">无效</Option>
                                    <Option value="1">有效</Option>
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
                        <Button @click="add" type="primary" icon="md-add" v-has="'add'">新增用户</Button>
                        <Button @click="delAll" icon="md-trash" v-has="'delete'">批量删除</Button>
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

                        <Dropdown @on-click="handleDropdown" style="float:right">
                            <Button>
                                设置显示列
                                <Icon type="md-arrow-dropdown"/>
                            </Button>
                            <DropdownMenu slot="list" style="padding: 10px;">
                                <Checkbox-group v-model="tableColumnsChecked" @on-change="changeTableColumns">
                                    <Checkbox v-for="(item) in allColumns" :label="item.key">{{item.title}}</Checkbox>
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

        <Modal :title="modalTitle" v-model="userModalVisible" :mask-closable='false' :width="500"
               :styles="{top: '30px'}">
            <Form ref="userForm" :model="userForm" :label-width="70" :rules="userFormValidate">
                <FormItem label="用户名" prop="username">
                    <Input v-model="userForm.username" autocomplete="off"/>
                </FormItem>
                <FormItem label="密码" prop="password" v-if="modalType===0" :error="errorPass">
                    <Input type="password" v-model="userForm.password" autocomplete="off"/>
                </FormItem>
                <FormItem label="邮箱" prop="email">
                    <Input v-model="userForm.email"/>
                </FormItem>
                <FormItem label="手机号" prop="mobile">
                    <Input v-model="userForm.mobile"/>
                </FormItem>
            </Form>
            <div slot="footer">
                <Button type="text" @click="cancelUser">取消</Button>
                <Button type="primary" :loading="submitLoading" @click="submitUser">提交</Button>
            </div>
        </Modal>

    </div>
</template>

<script>
    import {
        deleteUserInfo,
        disableUserInfo,
        enableUserInfo,
        getUserInfoListData,
        addUserInfo,
        editUserInfo
    } from "@/api/index";
    import moment from 'moment';

    export default {
        name: "userInfo-manage",
        data() {

            const validateMobile = (rule, value, callback) => {
                var reg = /^[1][3,4,5,7,8][0-9]{9}$/;
                if (!reg.test(value)) {
                    callback(new Error("手机号格式错误"));
                } else {
                    callback();
                }
            };

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
                tableColumnsChecked: ['username', 'mobile', 'email', 'status', 'createdAt'],
                searchForm: {
                    username: "",
                    mobile: "",
                    status: null,
                    startDate: "",
                    endDate: "",
                },
                errorPass: "",
                submitLoading: false,
                userForm: {
                    username: "",
                    email: "",
                    mobile: "",
                    password: "",
                },
                userFormValidate: {
                    username: [
                        {required: true, message: "账号不能为空", trigger: "blur"}
                    ],
                    mobile: [
                        {required: true, message: "手机号不能为空", trigger: "blur"},
                        {validator: validateMobile, trigger: "blur"}
                    ],
                    email: [
                        {required: true, message: "请输入邮箱地址"},
                        {type: "email", message: "邮箱格式不正确"}
                    ],
                    password: [
                        {required: true, message: "密码不能为空", trigger: "blur"}
                    ],
                },
                userModalVisible: false,
                modalTitle: "",
                selectDate: null,
                modalType: 0,
                columns: [],
                allColumns: [
                    {
                        title: "用户名",
                        key: "username",
                        sortable: true,
                        align: "center",
                    },
                    {
                        title: "手机号",
                        key: "mobile",
                        sortable: true,
                        align: "center",
                    },
                    {
                        title: "邮箱",
                        key: "email",
                        sortable: true,
                        align: "center",
                        render: (h, params) => {
                            return h("div", params.row.email ? params.row.email : '-');
                        },
                    },
                    {
                        title: "状态",
                        key: "status",
                        align: "center",
                        width: 140,
                        render: (h, params) => {
                            let re = "";
                            if (params.row.status === 1) {
                                return h("div", [
                                    h(
                                        "Tag",
                                        {
                                            props: {
                                                type: "dot",
                                                color: "success"
                                            }
                                        },
                                        "正常启用"
                                    )
                                ]);
                            } else if (params.row.status === 0) {
                                return h("div", [
                                    h(
                                        "Tag",
                                        {
                                            props: {
                                                type: "dot",
                                                color: "error"
                                            }
                                        },
                                        "禁用"
                                    )
                                ]);
                            }
                        },
                        filters: [
                            {
                                label: "正常启用",
                                value: 1
                            },
                            {
                                label: "禁用",
                                value: 0
                            }
                        ],
                        filterMultiple: false,
                        filterMethod(value, row) {
                            if (value === 1) {
                                return row.status === 1;
                            } else if (value === 0) {
                                return row.status === 0;
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
                this.initMeta();
                this.getUserInfoList();
            },

            initMeta() {
                let permTypes = this.$route.meta.permTypes;
                if (permTypes !== null && permTypes !== undefined) {
                    this.permTypes = permTypes;
                }
            },

            changePage(v) {
                this.searchForm.pageNumber = v;
                this.getUserInfoList();
                this.clearSelectAll();
            },
            changePageSize(v) {
                this.searchForm.pageSize = v;
                this.getUserInfoList();
            },
            selectDateRange(v) {
                if (v) {
                    this.searchForm.startDate = v[0];
                    this.searchForm.endDate = v[1];
                }
            },
            getUserInfoList() {
                // 多条件搜索配置列表
                this.loading = true;
                getUserInfoListData(this.searchForm).then(res => {
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
                this.getUserInfoList();
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
                this.getUserInfoList();
            },
            changeSort(e) {
                this.searchForm.sort = e.key;
                this.searchForm.order = e.order;
                if (e.order === "normal") {
                    this.searchForm.order = "";
                }
                this.getUserInfoList();
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
                                filename: "用户数据"
                            });
                        }
                    });
                } else if (name === "refresh") {
                    this.getUserInfoList();
                }
            },

            cancelUser() {
                this.userModalVisible = false;
            },
            submitUser() {
                this.$refs.userForm.validate(valid => {
                    if (valid) {
                        if (this.modalType === 0) {
                            // 添加用户 避免编辑后传入id
                            delete this.userForm.id;
                            delete this.userForm.status;
                            if (
                                this.userForm.password == "" ||
                                this.userForm.password == undefined
                            ) {
                                this.errorPass = "密码不能为空";
                                return;
                            }
                            if (this.userForm.password.length < 6) {
                                this.errorPass = "密码长度不得少于6位";
                                return;
                            }
                            this.submitLoading = true;
                            addUserInfo(this.userForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("操作成功");
                                    this.getUserInfoList();
                                    this.userModalVisible = false;
                                }
                            });
                        } else {
                            // 编辑
                            editUserInfo(this.userForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("操作成功");
                                    this.getUserInfoList();
                                    this.userModalVisible = false;
                                }
                            });
                        }
                    }
                });
            },

            add() {
                this.modalType = 0;
                this.modalTitle = "添加用户";
                this.$refs.userForm.resetFields();
                this.userModalVisible = true;
            },
            edit(v) {
                this.modalType = 1;
                this.modalTitle = "编辑用户";
                this.$refs.userForm.resetFields();
                // 转换null为""
                for (let attr in v) {
                    if (v[attr] === null) {
                        v[attr] = "";
                    }
                }
                let str = JSON.stringify(v);
                let userInfo = JSON.parse(str);
                this.userForm = userInfo;
                this.userModalVisible = true;
            },

            enable(v) {
                this.$Modal.confirm({
                    title: "确认启用",
                    content: "您确认要启用用户 " + v.username + " ?",
                    onOk: () => {
                        enableUserInfo(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("操作成功");
                                this.getUserInfoList();
                            }
                        });
                    }
                });
            },

            disable(v) {
                this.$Modal.confirm({
                    title: "确认禁用",
                    content: "您确认要禁用用户 " + v.username + " ?",
                    onOk: () => {
                        disableUserInfo(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("操作成功");
                                this.getUserInfoList();
                            }
                        });
                    }
                });
            },

            remove(v) {
                this.$Modal.confirm({
                    title: "确认删除",
                    content: "您确认要删除用户 " + v.username + " ?",
                    onOk: () => {
                        deleteUserInfo(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("删除成功");
                                this.getUserInfoList();
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
                        deleteUserInfo(ids).then(res => {
                            if (res.success === true) {
                                this.$Message.success("删除成功");
                                this.clearSelectAll();
                                this.getUserInfoList();
                            }
                        });
                    }
                });
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
                                            this.edit(params.row);
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
