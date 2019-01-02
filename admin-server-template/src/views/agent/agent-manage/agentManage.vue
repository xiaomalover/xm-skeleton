<style lang="less">
    @import "agentManage.less";
</style>
<template>
    <div class="search">
        <Row>
            <Col>
                <Card>
                    <Row>
                        <Form ref="searchForm" :model="searchForm" inline :label-width="70" class="search-form">
                            <Form-item label="手机号" prop="mobile">
                                <Input type="text" v-model="searchForm.mobile" clearable placeholder="手机号"
                                       style="width: 200px"/>
                            </Form-item>
                            <Form-item label="UID" prop="mobile">
                                <Input type="text" v-model="searchForm.id" clearable placeholder="UID"
                                       style="width: 200px"/>
                            </Form-item>
                            <Form-item label="代理等级" prop="level">
                                <Select v-model="searchForm.level" placeholder="请选择等级" clearable style="width: 200px">
                                    <Option value="2">会员</Option>
                                    <Option value="3">店长</Option>
                                    <Option value="4">区/县渠道商</Option>
                                    <Option value="5">市级渠道商</Option>
                                    <Option value="6">省级渠道商</Option>
                                </Select>
                            </Form-item>
                            <Form-item label="代理区域" prop="area">
                                <Input type="text" v-model="searchForm.area" clearable placeholder="代理区域"
                                       style="width: 200px"/>
                            </Form-item>
                            <!--<Form-item label="状态" prop="status">
                                <Select v-model="searchForm.status" placeholder="请选择状态" clearable style="width: 200px">
                                    <Option value="1">激活</Option>
                                    <Option value="0">锁定</Option>
                                </Select>
                            </Form-item>-->
                            <span v-if="drop">

                                <Form-item label="姓名" prop="mobile">
                                <Input type="text" v-model="searchForm.name" clearable placeholder="姓名"
                                       style="width: 200px"/>
                            </Form-item>

                                <Form-item label="昵称" prop="mobile">
                                <Input type="text" v-model="searchForm.nickname" clearable placeholder="昵称"
                                       style="width: 200px"/>
                            </Form-item>

                                <Form-item label="推荐手机" prop="recommendMobile">
                                <Input type="text" v-model="searchForm.recommendMobile" clearable placeholder="推荐人手机号"
                                       :readonly="recommendReadonly"
                                       style="width: 200px"/>
                            </Form-item>

                            </span>

                            <Form-item style="margin-left:-35px;" class="br">
                                <Button @click="handleSearch" type="primary" icon="ios-search">搜索</Button>
                                <Button @click="handleReset">重置</Button>
                                <Button @click="getAgentList" icon="md-refresh">刷新</Button>
                                <a class="drop-down" @click="dropDown">{{dropDownContent}}
                                    <Icon :type="dropDownIcon"></Icon>
                                </a>
                            </Form-item>
                        </Form>
                    </Row>
                    <Row class="operation">
                        <Button @click="add" type="primary" icon="md-add">添加代理</Button>
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
        <Modal :title="modalTitle" v-model="modalFlag" :mask-closable='false' :width="500"
               :styles="{top: '30px'}" @on-cancel="cancelAgent">
            <Form ref="agentForm" :model="agentForm" :label-width="70" :rules="agentFormValidate">
                <FormItem label="手机号" prop="mobile" v-if="editMobileFlag || addFlag">
                    <Input v-model="agentForm.mobile" autocomplete="off" placeholder="手机号" @on-blur="getRecommend"/>
                </FormItem>
                <FormItem label="姓名" prop="name" v-if="addFlag">
                    <Input v-model="agentForm.name" autocomplete="off" placeholder="姓名"/>
                </FormItem>
                <input type="hidden" v-model="agentForm.id"/>
                <FormItem label="推荐人" prop="recommendMobile" v-if="editRecommendFlag || addFlag">
                    <Input v-model="agentForm.recommendMobile" autocomplete="off" placeholder="推荐人手机号或UID"
                           @on-blur="checkRecommend"/>
                </FormItem>
                <FormItem label="代理等级" prop="level" v-if="editLevelFlag || addFlag">
                    <Select v-model="agentForm.level" placeholder="代理等级" @on-change="changeLevel()">
                        <Option value="2">会员</Option>
                        <Option value="3">店长</Option>
                        <Option value="4">区/县渠道商</Option>
                        <Option value="5">市级渠道商</Option>
                        <Option value="6">省级渠道商</Option>
                    </Select>
                </FormItem>
                <FormItem label="选择地区" prop="address" v-if="(addFlag || editLevelFlag) && selectAreaFlag">
                    <div v-show="agentForm.level == 6">
                        <al-cascader v-model="agentForm.addressArray" @on-change="changeAddress" data-type="code"
                                     :level="0" style="width:250px"/>
                    </div>
                    <div v-show="agentForm.level == 5">
                        <al-cascader v-model="agentForm.addressArray" @on-change="changeAddress" data-type="code"
                                     :level="1" style="width:250px"/>
                    </div>
                    <div v-show="agentForm.level == 4">
                        <al-cascader v-model="agentForm.addressArray" @on-change="changeAddress" data-type="code"
                                     :level="2" style="width:250px"/>
                    </div>
                </FormItem>
            </Form>
            <div slot="footer">
                <Button type="text" @click="cancelAgent">取消</Button>
                <Button type="primary" :loading="submitLoading" @click="submitAgent">提交</Button>
            </div>
        </Modal>

        <Modal :title="disableTitle" v-model="disableFlag" :mask-closable='false' :width="500"
               :styles="{top: '30px'}" @on-cancel="cancelDisable">
            <Form ref="disableForm" :model="disableForm" :label-width="70" :rules="disableFormValidate">
                <FormItem label="代理等级" prop="level">
                    <Select v-model="disableForm.level" placeholder="禁用前，请选择一个代理等级">
                        <Option value="2">会员</Option>
                        <Option value="3">店长</Option>
                    </Select>
                    <input type="hidden" v-model="disableForm.id"/>
                </FormItem>
            </Form>
            <div slot="footer">
                <Button type="text" @click="cancelDisable">取消</Button>
                <Button type="primary" :loading="submitLoading" @click="doDisable">提交</Button>
            </div>
        </Modal>
    </div>
</template>

<script>
    var moment = require('moment');

    import {
        getAgents,
        editMobile,
        addAgent,
        editRecommend,
        editLevel,
        checkRecommend,
        getRecommend,
        enableAreaAgent,
        disableAreaAgent
    } from "@/api/index";

    export default {
        name: "help-manage",
        data() {
            return {
                accessToken: {},
                loading: true,
                editor: '',
                drop: false,
                fullscreen: false,
                dropDownContent: "展开",
                dropDownIcon: "ios-arrow-down",
                disableFlag: false,
                disableTitle: "禁用区域代理",
                selectCount: 0,
                selectList: [],
                modalFlag: false,
                addFlag: false,
                editMobileFlag: false,
                editRecommendFlag: false,
                editLevelFlag: false,
                selectAreaFlag: false,
                recommendReadonly: false,
                searchForm: {
                    name: "",
                    mobile: "",
                    nickname: "",
                    recommendMobile: "",
                    status: -1,
                    level: null,
                },
                selectDate: null,
                modalType: 0,
                agentModalVisible: false,
                modalTitle: "",

                agentForm: {
                    mobile: null,
                    recommendMobile: "",
                    level: "",
                    address: "",
                    addressArray: [],
                    selectLevel: 0,
                    name: "",
                },
                disableForm: {
                    id: null,
                    level: "",
                },
                disableFormValidate: {
                    level: [
                        {required: true, message: "禁用区域代理前，请先选择一个普通代理等级", trigger: "blur"}
                    ],
                },

                agentFormValidate: {
                    mobile: [
                        {required: true, message: "代理手机号不能为空", trigger: "blur"}
                    ],
                    recommendMobile: [
                        {required: true, message: "推荐人手机号不能为空", trigger: "blur"}
                    ],
                    level: [
                        {required: true, message: "等级不能为空", trigger: "blur"}
                    ],
                },
                editMobileFormValidate: {
                    mobile: [
                        {required: true, message: "代理手机号不能为空"}
                    ],
                },
                editRecommendFormValidate: {
                    recommendMobile: [
                        {required: true, message: "推荐人手机号不能为空", trigger: "blur"}
                    ],
                },
                editLevelFormValidate: {
                    level: [
                        {required: true, message: "请选择等级"}
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
                        title: "UID",
                        key: "id",
                        align: "center",
                        sortable: true,
                    },
                    {
                        title: "手机号",
                        key: "mobile",
                        align: "center",
                        sortable: true,
                    },
                    {
                        title: "昵称",
                        key: "nickname",
                        align: "center",
                        sortable: true,
                    },
                    {
                        title: "姓名",
                        key: "name",
                        sortable: true,
                        align: "center",
                        type: "html",
                    },
                    {
                        title: "代理等级",
                        key: "level",
                        align: "center",
                        render: (h, params) => {
                            let re = "";
                            if (params.row.level === 1) {
                                re = "游客";
                            } else if (params.row.level === 2) {
                                re = "会员";
                            } else if (params.row.level === 3) {
                                re = "店长";
                            } else if (params.row.level === 4) {
                                re = "区/县渠道商";
                            } else if (params.row.level === 5) {
                                re = "市级渠道商";
                            } else if (params.row.level === 6) {
                                re = "省级渠道商";
                            }
                            return h("div", re);
                        }
                    },
                    {
                        title: "代理区域",
                        key: "areaNames",
                        sortable: true,
                        align: "center",
                        type: "html",
                        width: 200,
                        render: (h, params) => {
                            let re = "";
                            if (params.row.areaNames !== "") {
                                re = params.row.areaNames;
                            } else {
                                re = "-";
                            }
                            return h("div", re);
                        }
                    },
                    {
                        title: "推荐人手机",
                        key: "recommendMobile",
                        sortable: true,
                        align: "center",
                        type: "html",
                    },
                    {
                        title: "推荐人昵称",
                        key: "recommendNickname",
                        sortable: true,
                        align: "center",
                        type: "html",
                    },
                    {
                        title: "注册时间",
                        key: "ctime",
                        sortable: true,
                        width: 150,
                        render: (h, params) => {
                            return h("div", moment.unix(params.row.ctime).format('YYYY-MM-DD HH:mm:ss'));
                        }
                    },
                    {
                        title: "操作",
                        key: "action",
                        width: 400,
                        align: "center",
                        fixed: "right",
                        render: (h, params) => {
                            let operater = [
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
                                                this.edit(params.row, "mobile");
                                            }
                                        }
                                    },
                                    "修改手机号"
                                ),
                                h(
                                    "Button",
                                    {
                                        props: {
                                            type: "default",
                                            size: "small"
                                        },
                                        style: {
                                            marginRight: "5px"
                                        },
                                        on: {
                                            click: () => {
                                                this.edit(params.row, "recommendMobile");
                                            }
                                        }
                                    },
                                    "修改推荐人"
                                ),
                                h(
                                    "Button",
                                    {
                                        props: {
                                            type: "error",
                                            size: "small"
                                        },
                                        style: {
                                            marginRight: "5px"
                                        },
                                        on: {
                                            click: () => {
                                                this.edit(params.row, "level");
                                                this.changeLevel();
                                            }
                                        }
                                    },
                                    "修改等级"
                                ),
                            ];

                            if (params.row.address) {
                                if (params.row.areaStatus === 1) {
                                    operater.push(
                                        h(
                                            "Button",
                                            {
                                                props: {
                                                    type: "default",
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
                                            "禁用区域代理",
                                        ),
                                    );
                                } else {
                                    operater.push(
                                        h(
                                            "Button",
                                            {
                                                props: {
                                                    type: "default",
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
                                            "启用区域代理",
                                        ),
                                    );
                                }
                            }
                            return h("div", operater);
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
                this.getAgentList();
            },

            changePage(v) {
                this.searchForm.pageNumber = v;
                this.getAgentList();
                this.clearSelectAll();
            },
            changePageSize(v) {
                this.searchForm.pageSize = v;
                this.getAgentList();
            },
            selectDateRange(v) {
                if (v) {
                    this.searchForm.startDate = v[0];
                    this.searchForm.endDate = v[1];
                }
            },
            getAgentList() {
                // 多条件搜索配置列表
                this.loading = true;
                getAgents(this.searchForm).then(res => {
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
                this.getAgentList();
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
                this.getAgentList();
            },
            changeSort(e) {
                this.searchForm.sort = e.key;
                this.searchForm.order = e.order;
                if (e.order === "normal") {
                    this.searchForm.order = "";
                }
                this.getAgentList();
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
                                filename: "代理数据"
                            });
                        }
                    });
                } else if (name === "refresh") {
                    this.getAgentList();
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
            cancelAgent() {
                this.modalFlag = false;
                this.addFlag = false;
                this.editMobileFlag = false;
                this.editRecommendFlag = false;
                this.editLevelFlag = false;
                this.selectAreaFlag = false;
                //重置值
                this.agentForm.mobile = "";
                this.agentForm.recommendMobile = "";
                this.agentForm.level = "";
                this.agentForm.address = "";
                this.agentForm.addressArray = [];
            },
            submitAgent() {
                this.$refs.agentForm.validate(valid => {
                    if (valid) {
                        if (this.modalType === 0) {
                            // 添加代理商 去除多余的，避免修改时form残留元素
                            delete this.agentForm.id;
                            delete this.agentForm.nickname;
                            delete this.agentForm.ctime;
                            delete this.agentForm.status;

                            this.submitLoading = true;
                            addAgent(this.agentForm).then(res => {
                                this.submitLoading = false;
                                if (res.success === true) {
                                    this.$Message.success("操作成功");
                                    this.getAgentList();
                                    this.cancelAgent();
                                }
                            });
                        } else {
                            delete this.agentForm.status;
                            // 编辑
                            if (this.editLevelFlag) {
                                editLevel(this.agentForm).then(res => {
                                    this.submitLoading = false;
                                    if (res.success === true) {
                                        this.$Message.success("操作成功");
                                        this.getAgentList();
                                        this.cancelAgent();
                                    }
                                });
                            } else if (this.editMobileFlag) {
                                editMobile(this.agentForm).then(res => {
                                    this.submitLoading = false;
                                    if (res.success === true) {
                                        this.$Message.success("操作成功");
                                        this.getAgentList();
                                        this.cancelAgent();
                                    }
                                });
                            } else if (this.editRecommendFlag) {
                                editRecommend(this.agentForm).then(res => {
                                    this.submitLoading = false;
                                    if (res.success === true) {
                                        this.$Message.success("操作成功");
                                        this.getAgentList();
                                        this.cancelAgent();
                                    }
                                });
                            }
                        }
                    }
                });
            },
            changeLevel() {
                //console.log(this.agentForm);
                this.selectAreaFlag = false;
                if (this.agentForm.level > 3) {
                    if (this.agentForm.level == 4) {
                        this.agentForm.selectLevel = 2;
                    } else if (this.agentForm.level == 5) {
                        this.agentForm.selectLevel = 1;
                    } else if (this.agentForm.level == 6) {
                        this.agentForm.selectLevel = 0;
                    }
                    this.selectAreaFlag = true;
                }
            },

            add() {
                this.modalType = 0;
                this.modalTitle = "添加代理";
                this.$refs.agentForm.resetFields();
                this.modalFlag = true;
                this.addFlag = true;
                this.agentForm.name = "";
            },
            edit(v, type) {
                this.modalType = 1;
                this.$refs.agentForm.resetFields();
                // 转换null为""
                for (let attr in v) {
                    if (v[attr] === null) {
                        v[attr] = "";
                    }
                }
                let str = JSON.stringify(v);
                let agentInfo = JSON.parse(str);
                this.agentForm = agentInfo;
                if (this.agentForm.level === 4) {
                    this.agentForm.selectLevel = 2;
                } else if (this.agentForm.level === 5) {
                    this.agentForm.selectLevel = 1;
                } else if (this.agentForm.level === 6) {
                    this.agentForm.selectLevel = 0;
                }

                this.agentForm.level = agentInfo.level + "";

                if (agentInfo.address !== null && agentInfo.address !== "" && agentInfo.address) {
                    //console.log(agentInfo.address);
                    this.agentForm.address = agentInfo.address;
                    this.agentForm.addressArray = agentInfo.address.split(",");
                    this.agentForm.selectAreaFlag = true;
                } else {
                    this.agentForm.addressArray = [];
                    this.agentForm.address = "";
                }

                this.modalFlag = true;
                if (type === "mobile") {
                    this.modalTitle = "修改手机号";
                    this.editMobileFlag = true;
                } else if (type === "recommendMobile") {
                    this.editRecommendFlag = true;
                    this.modalTitle = "修改推荐人";
                } else if (type === "level") {
                    this.editLevelFlag = true;
                    this.modalTitle = "修改等级";
                }
            },
            enable(v) {
                this.$Modal.confirm({
                    title: "确认启用",
                    content: "您确认要启用区域代理 " + v.mobile + " ?",
                    onOk: () => {
                        //console.log(v.id);
                        enableAreaAgent(v.id).then(res => {
                            if (res.success === true) {
                                this.$Message.success("操作成功");
                                this.getAgentList();
                            }
                        });
                    }
                });
            },
            disable(row) {
                //console.log(row);
                this.disableFlag = true;
                this.disableForm.id = row.id;
            },
            changeAddress() {
                this.agentForm.address = JSON.stringify(this.agentForm.addressArray);
            },
            checkRecommend() {
                let params = {recommendMobile: this.agentForm.recommendMobile};
                checkRecommend(params).then(res => {
                    if (res.success === true) {
                        this.$Message.success("推荐人: " + res.result + " 有效");
                    }
                });
            },
            getRecommend() {
                let params = {mobile: this.agentForm.mobile};
                getRecommend(params).then(res => {
                    if (res.result != null) {
                        if (res.result.name != null) {
                            this.agentForm.name = res.result.name;
                        }
                        if (res.result.recommendMobile != null) {
                            this.agentForm.recommendMobile = res.result.recommendMobile;
                        }
                        this.recommendReadonly = true;
                    } else {
                        this.recommendReadonly = false;
                        this.agentForm.recommendMobile = ""; //TODO readonly not valid
                        this.agentForm.name = "";
                    }
                });
            },
            cancelDisable() {
                this.disableFlag = false;
                this.disableForm.level = "";
                this.disableForm.id = null;
            },
            doDisable() {
                this.$refs.disableForm.validate(valid => {
                    if (valid) {
                        this.disableFlag = false;
                        disableAreaAgent(this.disableForm.id, this.disableForm.level).then(res => {
                            if (res.success === true) {
                                this.$Message.success("操作成功");
                                this.getAgentList();
                                this.disableForm.id = null;
                                this.disableForm.level = "";
                            }
                        })
                    }
                });
            }
        },
        mounted() {
            this.init();
        }
    };
</script>
