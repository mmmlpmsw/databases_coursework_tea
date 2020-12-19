import Vue from 'vue'
import App from './App.vue'
import CheatCode from '$src/lib/CheatCode'

require('file-loader?name=[name].[ext]!./index.html');

window.cheatCode = new CheatCode();

new Vue({
  el: '#app',
  render: h => h(App)
});