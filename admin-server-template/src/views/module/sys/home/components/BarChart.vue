<template>
    <div :class="className" :style="{height:height,width:width}"></div>
</template>

<script>
    import BarCharts from 'echarts'

    require('echarts/theme/macarons'); // echarts theme
    import {debounce} from './utils/index'

    const animationDuration = 6000;

    export default {
        props: {
            className: {
                type: String,
                default: 'chart'
            },
            width: {
                type: String,
                default: '100%'
            },
            height: {
                type: String,
                default: '300px'
            },
            barChartData:{
                type:Object,
                require: true,
            }
        },
        data() {
            return {
                chart: null
            }
        },
        watch: {
            barChartData: {
                deep: true,
                handler(val) {
                    this.setOptions(val)
                }
            }
        },
        mounted() {
            this.initChart();
            this.__resizeHandler = debounce(() => {
                if (this.chart) {
                    this.chart.resize()
                }
            }, 100);
            window.addEventListener('resize', this.__resizeHandler)
        },
        beforeDestroy() {
            if (!this.chart) {
                return
            }
            window.removeEventListener('resize', this.__resizeHandler);
            this.chart.dispose();
            this.chart = null
        },
        methods: {
            setOptions({dates, counts} = {}) {
                this.chart.setOption({
                    /*title: {
                        text: '用户相关统计',
                        left:'right',
                        textStyle:{
                            //文字颜色
                            //color:'#ccc',
                            //字体风格,'normal','italic','oblique'
                            fontStyle:'normal',
                            //字体粗细 'normal','bold','bolder','lighter',100 | 200 | 300 | 400...
                            fontWeight:'bold',
                            //字体系列
                            fontFamily:'sans-serif',
                            //字体大小
                            fontSize:14,
                        },
                    },*/
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: { // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    grid: {
                        top: 10,
                        left: '2%',
                        right: '2%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: [{
                        type: 'category',
                        data: dates,
                        axisTick: {
                            alignWithLabel: true
                        }
                    }],
                    yAxis: [{
                        type: 'value',
                        axisTick: {
                            show: false
                        }
                    }],
                    series: [{
                        name: '注册用户总数',
                        type: 'bar',
                        stack: 'vistors',
                        barWidth: '60%',
                        data: counts,
                        animationDuration
                    }]
                })
            },
            initChart() {
                this.chart = BarCharts.init(this.$el, 'macarons');
                this.setOptions(this.barChartData);
            },
        }
    }
</script>
