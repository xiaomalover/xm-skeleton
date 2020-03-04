<style lang="less">
    @import "home.less";
    @import "../../../../styles/common.less";
</style>

<template>
    <div class="home-main">

        <Row :gutter="5">
            <Col :xs="24" :sm="12" :md="6" :style="{marginBottom: '10px'}">
                <infor-card id-name="user_created_count" :end-val="countData.completeProfitAmount" iconType="ios-pizza"
                            color="#2d8cf0" intro-text="测试数据1"></infor-card>
            </Col>
            <Col :xs="24" :sm="12" :md="6" :style="{marginBottom: '10px'}">
                <infor-card id-name="visit_count" :end-val="countData.completeProfitCount" iconType="md-add-circle"
                            color="#64d572"
                            :iconSize="50" intro-text="测试数据2"></infor-card>
            </Col>
            <Col :xs="24" :sm="12" :md="6" :style="{marginBottom: '10px'}">
                <infor-card id-name="collection_count" :end-val="countData.preProfitCount" iconType="md-basket"
                            color="#ffd572"
                            intro-text="测试数据3"></infor-card>
            </Col>
            <Col :xs="24" :sm="12" :md="6" :style="{marginBottom: '10px'}">
                <infor-card id-name="transfer_count" :end-val="countData.canceledProfitCount"
                            iconType="ios-analytics" color="#f25e43"
                            intro-text="测试数据4"></infor-card>
            </Col>
        </Row>

        <!--<Row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
            <bar-chart :bar-chart-data="barChartData"/>
        </Row>-->

        <Row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
            <line-chart :line-chart-data="lineChartData" :dates="dates"/>
        </Row>
    </div>
</template>

<script>

    import {ipInfo} from "@/api/index";
    import countUp from "./components/countUp.vue";
    import inforCard from "./components/inforCard.vue";
    import LineChart from './components/LineChart';
    //import BarChart from './components/BarChart';
    //import PieChart from './components/PieChart';

    import {
        getDashboardData,
    } from "@/api/index";

    export default {
        name: "home",
        components: {
            countUp,
            inforCard,
            LineChart,
            // BarChart,
            // PieChart
        },
        data() {
            return {
                showVideo: true,
                countData: {
                    completeProfitAmount: 0,
                    completeProfitCount: 0,
                    preProfitCount: 0,
                    canceledProfitCount: 0,
                },
                lineChartData: {},
                barChartData: {},
                dates: {},
            };
        },

        methods: {
            init: function () {
                getDashboardData().then(res => {
                    this.countData.preProfitCount = res.result.preProfitCount ? res.result.preProfitCount : 0;
                    this.countData.completeProfitAmount = res.result.completeProfitAmount ? res.result.completeProfitAmount : 0;
                    this.countData.completeProfitCount = res.result.completeProfitCount ? res.result.completeProfitCount : 0;
                    this.countData.canceledProfitCount = res.result.canceledProfitCount ? res.result.canceledProfitCount : 0;
                    //this.barChartData = res.result.userHistoryCount;
                    this.lineChartData = res.result.profitAmountData;
                    this.dates = res.result.profitAmountData.dates; //莫名奇妙，dates不传过去，刷新就没有了
                });
            },
        },
        mounted() {
            this.init();
        }
    };
</script>
