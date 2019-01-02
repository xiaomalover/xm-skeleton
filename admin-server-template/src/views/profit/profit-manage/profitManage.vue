<style lang="less">
    @import "profitManage.less";
</style>
<template>
    <div class="search">
        <Row>
            <Col>
                <Card>
                    <Row>
                        <Form ref="searchForm" :model="searchForm" inline :label-width="70" class="search-form">
                            <Form-item label="来源单号" prop="fromSn">
                                <Input type="text" v-model="searchForm.fromSn" clearable placeholder="来源单号"
                                       style="width: 200px"/>
                            </Form-item>
                            <Form-item label="类型" prop="type">
                                <Select v-model="searchForm.type" placeholder="请选择类型" clearable style="width: 200px">
                                    <Option value="1">代理奖励</Option>
                                    <Option value="2">收货地址奖励</Option>
                                    <Option value="3">区域代理奖励</Option>
                                </Select>
                            </Form-item>
                            <Form-item label="状态" prop="status">
                                <Select v-model="searchForm.status" placeholder="请选择状态" clearable style="width: 200px">
                                    <Option value="1">预分润</Option>
                                    <Option value="2">已分润</Option>
                                    <Option value="3">已取消</Option>
                                </Select>
                            </Form-item>

                            <span v-if="drop">

                                <Form-item label="创建时间">
                                <DatePicker v-model="selectDate" type="daterange" format="yyyy-MM-dd" clearable
                                            @on-change="selectDateRange" placeholder="选择起始时间"
                                            style="width: 200px"></DatePicker>
                            </Form-item>
                                <Form-item label="收益用户" prop="name">
                                <Input type="text" v-model="searchForm.name" clearable placeholder="收益用户"
                                       style="width: 200px"/>
                            </Form-item>
                            <Form-item label="收益手机" prop="mobile">
                                <Input type="text" v-model="searchForm.mobile" clearable placeholder="收益用户手机"
                                       style="width: 200px"/>
                            </Form-item>

                                <Form-item label="下单用户" prop="fromName">
                                    <Input type="text" v-model="searchForm.fromName" clearable placeholder="下单用户"
                                           style="width: 200px"/>
                                </Form-item>

                                <Form-item label="下单手机" prop="fromMobile">
                                    <Input type="text" v-model="searchForm.fromMobile" clearable placeholder="下单用户手机"
                                           style="width: 200px"/>
                                </Form-item>

                            </span>

                            <Form-item style="margin-left:-35px;" class="br">
                                <Button @click="handleSearch" type="primary" icon="ios-search">搜索</Button>
                                <Button @click="handleReset">重置</Button>
                                <Button @click="getProfitLogList" icon="md-refresh">刷新</Button>
                                <a class="drop-down" @click="dropDown">{{dropDownContent}}
                                    <Icon :type="dropDownIcon"></Icon>
                                </a>
                            </Form-item>
                        </Form>
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
    </div>
</template>

<script>
    var moment = require('moment');

    import {
        getProfitLogs,
    } from "@/api/index";

    export default {
        name: "help-manage",
        data() {
            return {
                accessToken: {},
                loading: true,
                editor: '',
                drop: false,
                fullscreen:false,
                dropDownContent: "展开",
                dropDownIcon: "ios-arrow-down",
                selectCount: 0,
                selectList: [],
                searchForm: {
                    name: "",
                    mobile: "",
                    fromName: "",
                    fromMobile: "",
                    status:null,
                    type:null,
                    fromSn: "",
                    startDate: "",
                    endDate: "",
                },
                selectDate: null,
                modalType: 0,
                helpModalVisible: false,
                modalTitle: "",
                columns: [
                    {
                        title: "收益用户",
                        key: "name",
                        align: "center",
                        sortable: true,
                    },
                    {
                        title: "收益用户ID",
                        key: "id",
                        align: "center",
                        sortable: true,
                    },
                    {
                        title: "收益用户手机",
                        key: "mobile",
                        sortable: true,
                        align: "center",
                        type:"html",
                    },
                    {
                        title: "收益用户等级",
                        key: "memberLevel",
                        align: "center",
                        render: (h, params) => {
                            let re = "";
                            if (params.row.memberLevel === 1) {
                                re = "游客";
                            } else if (params.row.memberLevel === 2) {
                                re = "会员";
                            } else if (params.row.memberLevel === 3) {
                                re = "店长";
                            } else if (params.row.memberLevel === 4) {
                                re = "区/县渠道商";
                            } else if (params.row.memberLevel === 5) {
                                re = "市级渠道商";
                            } else if (params.row.memberLevel === 6) {
                                re = "省级渠道商";
                            }
                            return h("div", re);
                        }
                    },
                    {
                        title: "金额",
                        key: "money",
                        sortable: true,
                        align: "center",
                        type:"html",
                    },
                    {
                        title: "下单用户",
                        key: "fromName",
                        sortable: true,
                        align: "center",
                        type:"html",
                    },
                    {
                        title: "下单用户ID",
                        key: "fromUser",
                        align: "center",
                        sortable: true,
                    },
                    {
                        title: "下单用户手机",
                        key: "fromMobile",
                        sortable: true,
                        align: "center",
                        type:"html",
                    },
                    {
                        title: "下单用户等级",
                        key: "fromMemberLevel",
                        align: "center",
                        render: (h, params) => {
                            let re = "";
                            if (params.row.fromMemberLevel === 1) {
                                re = "游客";
                            } else if (params.row.fromMemberLevel === 2) {
                                re = "会员";
                            } else if (params.row.fromMemberLevel === 3) {
                                re = "店长";
                            } else if (params.row.fromMemberLevel === 4) {
                                re = "区/县渠道商";
                            } else if (params.row.fromMemberLevel === 5) {
                                re = "市级渠道商";
                            } else if (params.row.fromMemberLevel === 6) {
                                re = "省级渠道商";
                            }
                            return h("div", re);
                        }
                    },
                    {
                        title: "来源订单号",
                        key: "orderSn",
                        sortable: true,
                        align: "center",
                        type:"html",
                    },
                    {
                        title: "类型",
                        key: "type",
                        align: "center",
                        render: (h, params) => {
                            let re = "";
                            if (params.row.profitType === 1) {
                                re = "代理奖励";
                            } else if (params.row.profitType === 2) {
                                re = "收货地址奖励";
                            } else if (params.row.profitType === 3) {
                                re = "区域代理奖励";
                            }
                            return h("div", re);
                        },
                        filters: [
                            {
                                label: "代理奖励",
                                value: 1
                            },
                            {
                                label: "收货地址奖励",
                                value: 2
                            },
                            {
                                label: "区域代理奖励",
                                value: 2
                            }
                        ],
                        filterMultiple: false,
                        filterMethod(value, row) {
                            if (value === 1) {
                                return row.profitType === 1;
                            } else if (value === 2) {
                                return row.profitType === 2;
                            } else if (value === 3) {
                                return row.profitType === 3;
                            }
                        }
                    },
                    {
                        title: "状态",
                        key: "status",
                        width: 90,
                        align: "center",
                        render: (h, params) => {
                            let re = "";
                            if (params.row.status === 1) {
                                re = "预分润";
                            } else if (params.row.status === 2) {
                                re = "已分润";
                            } else if (params.row.status === 3) {
                                re = "已取消";
                            }
                            return h("div", re);
                        },
                        filters: [
                            {
                                label: "预分润",
                                value: 1
                            },
                            {
                                label: "已分润",
                                value: 2
                            },
                            {
                                label: "已取消",
                                value: 3
                            }
                        ],
                        filterMultiple: false,
                        filterMethod(value, row) {
                            if (value === 1) {
                                return row.status === 1;
                            } else if (value === 2) {
                                return row.status === 2;
                            } else if (value === 3) {
                                return row.status === 3;
                            }
                        }
                    },
                    {
                        title: "创建时间",
                        key: "createdAt",
                        sortable: true,
                        width: 150,
                        render: (h, params) => {
                            return h("div", moment.unix(params.row.created_at).format('YYYY-MM-DD HH:mm:ss'));
                        }
                    },
                    {
                        title: "备注",
                        key: "remark",
                        sortable: true,
                        align: "center",
                        type:"html",
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
                this.getProfitLogList();
            },

            changePage(v) {
                this.searchForm.pageNumber = v;
                this.getProfitLogList();
                this.clearSelectAll();
            },
            changePageSize(v) {
                this.searchForm.pageSize = v;
                this.getProfitLogList();
            },
            selectDateRange(v) {
                if (v) {
                    this.searchForm.startDate = v[0];
                    this.searchForm.endDate = v[1];
                }
            },
            getProfitLogList() {
                // 多条件搜索配置列表
                this.loading = true;
                getProfitLogs(this.searchForm).then(res => {
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
                this.getProfitLogList();
            },
            handleReset() {
                this.$refs.searchForm.resetFields();
                this.searchForm.pageNumber = 1;
                this.searchForm.pageSize = 10;
                this.selectDate = null;
                this.searchForm.startDate = "";
                this.searchForm.endDate = "";
                this.selectDep = [];
                this.searchForm.departmentId = "";
                // 重新加载数据
                this.getProfitLogList();
            },
            changeSort(e) {
                this.searchForm.sort = e.key;
                this.searchForm.order = e.order;
                if (e.order === "normal") {
                    this.searchForm.order = "";
                }
                this.getProfitLogList();
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
                                filename: "分润数据"
                            });
                        }
                    });
                } else if (name === "refresh") {
                    this.getProfitLogList();
                }
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
        },
        mounted() {
            this.init();
        }
    };
</script>
