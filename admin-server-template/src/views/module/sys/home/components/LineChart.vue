<template>
    <div :class="className" :style="{height:height,width:width}"></div>
</template>

<script>
    import echarts from 'echarts'

    require('echarts/theme/macarons'); // echarts theme
    import {debounce} from './utils/index'

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
                default: '580px'
            },
            autoResize: {
                type: Boolean,
                default: true
            },
            lineChartData: {
                type: Object,
                required: true
            },
            dates: {},
        },
        data() {
            return {
                chart: null
            }
        },
        watch: {
            lineChartData: {
                deep: true,
                handler(val) {
                    this.setOptions(val)
                }
            }
        },
        mounted() {
            this.initChart();
            if (this.autoResize) {
                this.__resizeHandler = debounce(() => {
                    if (this.chart) {
                        this.chart.resize()
                    }
                }, 100);
                window.addEventListener('resize', this.__resizeHandler)
            }

            // 监听侧边栏的变化
            const sidebarElm = document.getElementsByClassName('sidebar-menu-con')[0];
            sidebarElm.addEventListener('transitionend', this.sidebarResizeHandler)
        },
        beforeDestroy() {
            if (!this.chart) {
                return
            }
            if (this.autoResize) {
                window.removeEventListener('resize', this.__resizeHandler)
            }

            const sidebarElm = document.getElementsByClassName('sidebar-menu-con')[0];
            sidebarElm.removeEventListener('transitionend', this.sidebarResizeHandler);

            this.chart.dispose();
            this.chart = null
        },
        methods: {
            sidebarResizeHandler(e) {
                if (e.propertyName === 'width') {
                    this.__resizeHandler()
                }
            },
            setOptions({completeProfitAmount, preProfitAmount, canceledProfitAmount, dates} = {}) {
                this.chart.setOption({
                    xAxis: {
                        //data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        data: this.dates,
                        boundaryGap: false,
                        axisTick: {
                            show: false
                        }
                    },
                    grid: {
                        left: 10,
                        right: 10,
                        bottom: 20,
                        top: 30,
                        containLabel: true
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross'
                        },
                        padding: [5, 10]
                    },
                    yAxis: {
                        axisTick: {
                            show: false
                        }
                    },
                    legend: {
                        data: ['测试数据1', '测试数据2', '测试数据3']
                    },
                    series: [
                        {
                            name: '测试数据1', itemStyle: {
                                normal: {
                                    color: '#FF005A',
                                    lineStyle: {
                                        color: '#FF005A',
                                        width: 2
                                    }
                                }
                            },
                            smooth: true,
                            type: 'line',
                            data: completeProfitAmount,
                            animationDuration: 2800,
                            animationEasing: 'cubicInOut'
                        },
                        {
                            name: '测试数据2',
                            smooth: true,
                            type: 'line',
                            itemStyle: {
                                normal: {
                                    color: '#3888fa',
                                    lineStyle: {
                                        color: '#3888fa',
                                        width: 2
                                    },
                                    areaStyle: {
                                        color: '#f3f8ff'
                                    }
                                }
                            },
                            data: preProfitAmount,
                            animationDuration: 2800,
                            animationEasing: 'quadraticOut'
                        },
                        {
                            name: '测试数据3', itemStyle: {
                                normal: {
                                    color: '#FF005A',
                                    lineStyle: {
                                        color: '#FF005A',
                                        width: 2
                                    }
                                }
                            },
                            smooth: true,
                            type: 'line',
                            data: canceledProfitAmount,
                            animationDuration: 2800,
                            animationEasing: 'cubicInOut'
                        },
                        ]
                })
            },
            initChart() {
                this.chart = echarts.init(this.$el, 'macarons')
                this.setOptions(this.lineChartData)
            }
        }
    }
</script>
