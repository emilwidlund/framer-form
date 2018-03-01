const path = require('path');

module.exports = {
    entry: './example/app.coffee',
    output: {
        path: path.resolve(__dirname, 'example'),
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