const path = require('path');
const webpack = require('webpack');
const { VueLoaderPlugin } = require("vue-loader");
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  entry: './src/main.js',
  output: {
    path: path.join(__dirname, 'dist'),
    publicPath: '/dist',
    filename: 'main.js'
  },
  devServer: {
    historyApiFallback: true,
    noInfo: true,
    overlay: true,
    host: 'localhost',
    writeToDisk: true,
    port: 3000,
    hot: true,
    proxy: {
      'http://localhost/api/*': {
        target: `http://localhost:8080`
      }
    }
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          'vue-style-loader',
          'css-loader',
          'postcss-loader'
        ]
      }, {
        test: /\.scss$/,
        use: [
          'vue-style-loader',
          'css-loader',
          'postcss-loader',
          'sass-loader'
        ]
      }, {
        test: /\.vue$/,
        loader: 'vue-loader'
      }, {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      }, {
        test: /\.jpe?g$|\.ico$|\.gif$|\.png$|\.svg$|\.woff$|\.ttf$|\.wav$|\.mp3$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]?[hash]'
        }
      }, {
        test: /\.tsx?$/,
        use: [
          'babel-loader',
          'ts-loader'
        ],
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
      '$assets': path.resolve(__dirname, 'assets'),
      '$src': path.resolve(__dirname, 'src')
    },
    extensions: ['.*', '.vue', '.js', '.ts']
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new VueLoaderPlugin(),
    new CopyWebpackPlugin({
      patterns: [
        { from: 'assets' }
      ]
    })
  ],
  performance: {
    hints: false
  },
  optimization: {
    minimize: true
  },
  devtool: 'eval-source-map'
};

if (process.env.NODE_ENV === 'production') {
  module.exports.devtool = 'source-map';
  // http://vue-loader.vuejs.org/en/workflow/production.html
  module.exports.plugins = (module.exports.plugins || []).concat([
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"'
      }
    }),
    new webpack.LoaderOptionsPlugin({
      minimize: true
    })
  ])
}