import Vue from 'vue'
import App from './App.vue'
import CheatCode from '$src/lib/CheatCode'

window.cheatCode = new CheatCode();

new Vue({
  el: '#app',
  render: h => h(App)
});