<template>
  <div id="root" :theme-dark="$store.state.darkTheme">
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
  import Cheats from "$src/components/Cheats";
  import Stores from "$src/pages/Stores";
  import Factory from "$src/pages/Factory";
  import Orders from "$src/pages/Orders";
  import NotFound from "$src/pages/NotFound";

  import i18n_ru_RU from '$assets/i18n/ru_RU.js';
  import i18n_en_US from '$assets/i18n/en_US.js';

  Vue.use(VueRouter);
  Vue.use(VueI18n);
  Vue.use(Vuex);

  let router = initRouter();
  let i18n = initI18n();
  let store = initGlobalStore();

  function initRouter() {
    const routes = [
      { path: '/',        redirect: '/factory'  },
      { path: '/stores',  component: Stores     },
      { path: '/factory', component: Factory    },
      { path: '/orders',  component: Orders     },
      { path: '*',        component: NotFound   },
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
        darkTheme: false
      },
      mutations: {
        switchTheme(state) {
          state.darkTheme = !state.darkTheme;
        }
      }
    });
  }

  export default {
    components: {
      Cheats,
      VueRouter,
      'a-header': Header
    },
    router,
    store,
    i18n
  }
</script>

<style lang="scss">
  @import "~$src/style/global";
</style>