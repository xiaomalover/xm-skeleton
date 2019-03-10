module.exports = {
    devServer: {
        host: '127.0.0.1',
        port: 7777,
        proxy: {
            '/skeleton': {
                target: 'http://127.0.0.1:20003',
                ws: true
            },
            '/foo': {
                target: '<other_url>'
            }
        }
    },
    // 打包时不生成.map文件 避免看到源码
    productionSourceMap: false
};
