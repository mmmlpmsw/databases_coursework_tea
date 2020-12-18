let path = require('path');
let webpack = require('webpack');

module.exports = {
  entry: './src/main.js',
  output: {
    path: path.resolve(__dirname, './dist'),
    publicPath: '/dist/',
    filename: 'build.js'
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
        loader: 'vue-loader',
        options: {
          // TODO enable this if SCSS doesn't work, remove this otherwise
          // loaders: {
          //   // Since sass-loader (weirdly) has SCSS as its default parse mode, we map
          //   // the "scss" and "sass" values for the lang attribute to the right configs here.
          //   // other preprocessors should work out of the box, no loader config like this necessary.
          //   'scss': [
          //     'vue-style-loader',
          //     'css-loader',
          //     'postcss-loader',
          //     'sass-loader'
          //   ],
          //   'sass': [
          //     'vue-style-loader',
          //     'css-loader',
          //     'postcss-loader',
          //     'sass-loader?indentedSyntax'
          //   ]
          // }
        },
      }, {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      },  {
        test: /\.jpe?g$|\.ico$|\.gif$|\.png$|\.svg$|\.woff$|\.ttf$|\.wav$|\.mp3$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]?[hash]'
        }
      }
    ]
  },
  resolve: {
    alias: {
      // 'vue$': 'vue/dist/vue.esm.js', // todo not sure if this is needed
      '$assets': path.resolve(__dirname, 'assets'),
      '$src': path.resolve(__dirname, 'src')
    },
    extensions: ['*', '.js', '.vue', '.json']
  },
  devServer: {
    historyApiFallback: true,
    noInfo: true,
    overlay: true,
    host: 'localhost',
    port: 3000,
    hot: true,
    proxy: {
      'http://localhost/api/*': {
        target: `http://localhost:8080`
      }
    }
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    require("vue-loader")
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