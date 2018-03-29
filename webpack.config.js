const path = require('path');

module.exports = {
    entry: './debug/app.coffee',
    output: {
        path: path.resolve(__dirname, 'debug'),
        filename: 'app.js'
    },
    devServer: {
        disableHostCheck: true
    },
    module: {
        rules: [
            {
                test: /\.coffee$/,
                use: ['coffee-loader']
            }
        ]
    }
}