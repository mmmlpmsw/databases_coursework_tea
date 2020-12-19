<template>
  <div id="root">
    <a-header/>
    <router-view/>
    <cheats/>
  </div>
</template>

<script>
  import Vue from "vue";
  import VueRouter from "vue-router";
  import VueI18n from "vue-i18n";
  import Vuex from "vuex";

  import Header from "$src/components/Header";

  import i18n_ru_RU from '$assets/i18n/ru_RU.js';
  import i18n_en_US from '$assets/i18n/en_US.js';
  import Cheats from "$src/components/Cheats";

  Vue.use(VueRouter);
  Vue.use(Vuex);

  let router = initRouter();
  let i18n = initI18n();
  let store = initGlobalStore();

  function initRouter() {
    const routes = [
      { path: '/',        redirect: '/factory'  },
      { path: '/stores',  component: null       }, // todo
      { path: '/factory', component: null       }, // todo
      { path: '/orders',  component: null       }, // todo
    ];

    return new VueRouter({
      mode: 'history',
      routes
    });
  }

  function initI18n() {
    let messages = {
      'en_US': i18n_en_US,
      'en': i18n_en_US,
      'ru_RU': i18n_ru_RU,
      'ru': i18n_ru_RU
    };

    let locale = 'en_US';

    return new VueI18n({
      locale: locale,
      fallbackLocale: 'en_US',
      messages
    });
  }

  function initGlobalStore() {
    return new Vuex.Store({
      state: {
        // Empty for now
      },
      mutations: {
        // Empty for now
      }
    });
  }

  export default {
    components: {
      Cheats,
      'a-header': Header
    },
    router,
    store,
    i18n,
  }
</script>

<style>

</style>