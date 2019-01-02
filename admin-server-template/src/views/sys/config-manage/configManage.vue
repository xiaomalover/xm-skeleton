<style lang="less">
    @import "./configManage.less";
</style>
<template>
    <div class="search">
        <Row>
            <Col>
                <Card>
                    <Row>
                        <Form ref="searchForm" :model="searchForm" inline :label-width="70" class="search-form">
                            <Form-item label="配置名" prop="name">
                                <Input type="text" v-model="searchForm.name" clearable placeholder="请输入配置名"
                                       style="width: 200px"/>
                            </Form-item>
                            <Form-item label="配置值" prop="value">
                                <Input type="text" v-model="searchForm.value" clearable placeholder="请输入配置值"
                                       style="width: 200px"/>
                            </Form-item>

                            <Form-item label="类型" prop="enable">
                                <Select v-model="searchForm.type" placeholder="请选择" clearable style="width: 200px">
                                    <Option value="1">代理佣金配置</Option>
                                    <Option value="2">收货地址佣金配置</Option>
                                    <Option value="3">区域代理佣金配置</Option>
                                    <Option value="4">佣金备注配置</Option>
                                    <Option value="5">订单相关</Option>
                                </Select>
                            </Form-item>

                            <!--<Form-item label="状态" prop="enable">
                                <Select v-model="searchForm.status" placeholder="请选择" clearable style="width: 200px">
                                    <Option value="1">正常</Option>
                                    <Option value="0">禁用</Option>
                                </Select>
                            </Form-item>-->

                            <Form-item style="margin-left:-35px;" class="br">
                                <Button @click="handleSearch" type="primary" icon="ios-search">搜索</Button>
                                <Button @click="handleReset">重置</Button>
                            </Form-item>
                        </Form>
                    </Row>
                    <Row class="operation">
                        <Button @click="add" type="primary" icon="md-add">添加配置</Button>
                        <!--<Button @click="delAll" icon="md-trash">批量删除</Button>-->
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
        <Modal :title="modalTitle" v-model="configModalVisible" :mask-closable='false' :width="500"
               :styles="{top: '30px'}">
            <Form ref="configForm" :model="configForm" :label-width="70" :rules="configFormValidate">
                <FormItem label="配置名" prop="name">
                    <Input v-model="configForm.name" autocomplete="off" readonly="readonly" v-if="isUpdate"/>
                    <Input v-model="configForm.name" autocomplete="off" v-if="!isUpdate"/>
                </FormItem>
                <FormItem label="配置值" prop="value">
                    <Input v-model="configForm.value" autocomplete="off"/>
                </FormItem>
                <Form-item label="类型" prop="enable" v-if="!isUpdate">
                    <Select v-model="configForm.type" placeholder="请选择" clearable style="width: 200px">
                        <Option value="1">代理佣金配置</Option>
                        <Option value="2">收货地址佣金配置</Option>
                        <Option value="3">区域代理佣金配置</Option>
                        <Option value="4">佣金备注配置</Option>
                        <Option value="5">订单相关</Option>
                    </Select>
                </Form-item>
                <FormItem label="描述" prop="tips">
                    <Input v-model="configForm.tips" autocomplete="off"/>
                </FormItem>
            </Form>
            <div slot="footer">
                <Button type="text" @click="cancelConfig">取消</Button>
                <Button type="primary" :loading="submitLoading" @click="submitConfig">提交</Button>
            </div>
        </Modal>
    </div>
</template>

<script>
    import {
        getConfigListData,
        addConfig,
        editConfig,
        enableConfig,
        disableConfig,
        deleteConfig
    } from "@/api/index";

    export default {
        name: "config-manage",
        data() {
            return {
                accessToken: {},
                loading: true,
                drop: false,
                dropDownContent: "展开",
                dropDownIcon: "ios-arrow-down",
                selectCount: 0,
                selectList: [],
                viewImage: false,
                isUpdate: false,
                department: [],
                selectDep: [],
                dataDep: [],
                searchForm: {
                    name: null,
                    value: null,
                    enable: null,
                    tips: null,
                },
                selectDate: null,
                modalType: 0,
                configModalVisible: false,
                modalTitle: "",
                configForm: {
                    name: "",
                    value: "",
                    type: 1,
                    status: 1,
                    tips: "",
                },

                configFormValidate: {
                    name: [
                        {required: true, message: "配置名不能为空", trigger: "blur"}
                    ],
                    value: [
                        {required: true, message: "配置值不能为空", trigger: "blur"},
                    ],
                    type: [
                        {required: true, message: "配置类型不能为空", trigger: "blur"},
                    ],
                },

                submitLoading: false,

                columns: [
                    /*{
                        type: "selection",
                        width: 60,
                        align: "center",
                        fixed: "left"
                    },*/
                    {
                        type: "index",
                        width: 60,
                        align: "center",
                        fixed: "left"
                    },
                    {
                        title: "配置名",
                        key: "name",
                        sortable: true,
                        fixed: "left"
                    },
                    {
                        title: "配置值",
                        key: "value",
                        sortable: true,
                        fixed: "left"
                    },
                    {
                        title: "配置类型",
                        key: "type",
                        sortable: true,
                        align: "center",
                        fixed: "left",
                        render: (h, params) => {
                            let re = "";
                            switch (params.row.type) {
                                case 1:
                                    return h("div", "代理佣金配置");
                                case 2:
                                    return h("div", "收货地址佣金配置");
                                case 3:
                                    return h("div", "区域代理佣金配置");
                                case 4:
                                    return h("div", "佣金备注配置");
                                case 5:
                                    return h("div", "订单相关");
                            }
                        },
                    },
                    {
                        title: "描述信息",
                        key: "tips",
                        sortable: true,
                        align: "center",
                        fixed: "left",
                        render: (h, params) => {
                            let re = "";
                            if (params.row.tips) {
                                return h("div", params.row.tips);
                            } else {
                                return h("div", "-");
                            }
                        },
                    },

                    /*{
                        title: "状态",
                        key: "status",
                        align: "center",
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
                            if (value === 0) {
                                return row.status === 0;
                            } else if (value === 1) {
                                return row.status === 1;
                            }
                        }
                    },*/


                    {
                        title: "操作",
                        key: "action",
                        width: 100,
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
                                    /*h(
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
                                    )*/
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
            init() {
                this.accessToken = {
                    accessToken: this.getStore("accessToken")
                };
                this.getConfigList();
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

            loadData(item, callback) {
                item.loading = true;
                loadDepartment(item.value).then(res => {
                    item.loading = false;
                    if (res.success === true) {
                        res.result.forEach(function (e) {
                            if (e.isParent) {
                                e.value = e.configId;
                                e.label = e.title;
                                e.loading = false;
                                e.children = [];
                            } else {
                                e.value = e.configId;
                                e.label = e.title;
                            }
                            if (e.status === 0) {
                                e.label = "[已禁用] " + e.label;
                                e.disabled = true;
                            }
                        });
                        item.children = res.result;
                        callback();
                    }
                });
            },

            changePage(v) {
                this.searchForm.pageNumber = v;
                this.getConfigList();
                this.clearSelectAll();
            },
            changePageSize(v) {
                this.searchForm.pageSize = v;
                this.getConfigList();
            },
            getConfigList() {
                // 多条件搜索配置列表
                this.loading = true;
                getConfigListData(this.searchForm).then(res => {
                    this.loading = false;
                    if (res.success === true) {
                        this.data = res.result.content;
                        this.total = res.result.totalElements;
                    }
                });
            },
            handleSearch() {
                this.searchForm.pageNumber = 1;
                this.searchForm.pageSize = 10;
                this.getConfigList();
            },
            handleReset() {
                this.$refs.searchForm.resetFields();
                this.searchForm.pageNumber = 1;
                this.searchForm.pageSize = 10;
                this.selectDep = [];
                // 重新加载数据
                this.getConfigList();
            },
            changeSort(e) {
                this.searchForm.sort = e.key;
                this.searchForm.order = e.order;
                if (e.order === "normal") {
                    this.searchForm.order = "";
                }
                this.getConfigList();
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
                                filename: "配置数据"
                            });
                        }
                    });
                } else if (name === "refresh") {
                    this.getConfigList();
                }
            },
            cancelConfig() {
                this.configModalVisible = false;
            },

            submitConfig() {
                this.$refs.configForm.validate(valid => {
                    if (valid) {
                        if (this.modalType === 0) {
                            // 添加 避免编辑后传入id
                            delete this.configForm.id;
                            delete this.configForm.enable;
                            if (
                                this.configForm.name == "" ||
                                this.configForm.name == undefined
                            ) {
                                this.errorPass = "配置名不能为空";
                                return;
                            }

                            this.submitLoading = true;
                            addConfig(this.configForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("操作成功");
                                    this.getConfigList();
                                    this.configModalVisible = false;
                                }
                            });
                        } else {
                            // 编辑
                            editConfig(this.configForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("操作成功");
                                    this.getConfigList();
                                    this.configModalVisible = false;
                                }
                            });
                        }
                    }
                });
            },

            add() {
                this.isUpdate = false;
                this.modalType = 0;
                this.modalTitle = "添加配置";
                this.$refs.configForm.resetFields();
                this.configModalVisible = true;
            },
            edit(v) {
                this.isUpdate = true;
                this.modalType = 1;
                this.modalTitle = "修改配置";
                this.$refs.configForm.resetFields();
                // 转换null为""
                for (let attr in v) {
                    if (v[attr] === null) {
                        v[attr] = "";
                    }
                }
                let str = JSON.stringify(v);
                let configInfo = JSON.parse(str);
                this.configForm = configInfo;
                this.configModalVisible = true;
            },
            enable(v) {
                this.$Modal.confirm({
                    title: "确认启用",
                    content: "您确认要启用配置 " + v.name + " ?",
                    onOk: () => {
                        enableConfig(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("操作成功");
                                this.getConfigList();
                            }
                        });
                    }
                });
            },
            disable(v) {
                this.$Modal.confirm({
                    title: "确认禁用",
                    content: "您确认要禁用配置 " + v.name + " ?",
                    onOk: () => {
                        disableConfig(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("操作成功");
                                this.getConfigList();
                            }
                        });
                    }
                });
            },
            remove(v) {
                this.$Modal.confirm({
                    title: "确认删除",
                    content: "您确认要删除配置 " + v.name + " ?",
                    onOk: () => {
                        deleteConfig(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("删除成功");
                                this.getConfigList();
                            }
                        });
                    }
                });
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
                        deleteConfig(ids).then(res => {
                            if (res.success === true) {
                                this.$Message.success("删除成功");
                                this.clearSelectAll();
                                this.getConfigList();
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
