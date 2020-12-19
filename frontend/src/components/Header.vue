<template>
  <header class="header">
    <container>
      <div class="header_inner">
        <router-link to="/" class="logo header_text">KURSACH</router-link>
        <div class="nav">
          <router-link to="/stores" class="nav_btn header_text">STORES</router-link>
          <router-link to="/factory" class="nav_btn header_text">FACTORY</router-link>
          <router-link to="/orders" class="nav_btn header_text">ORDERS</router-link>
        </div>
        <theme-switch/>
      </div>
    </container>
  </header>
</template>

<script>
  import Container from "$src/components/Container";
  import ThemeSwitch from "$src/components/ThemeSwitch";
  export default {
    components: {
      Container,
      ThemeSwitch
    }
  }
</script>

<style scoped lang="scss">
  .header {
    background: black;
  }

  .header_inner {
    display: flex;
    align-items: center;
    flex-direction: row;
    justify-content: space-around;
  }

  .header_text {
    font-family: Arial, sans-serif;
    font-size: 32px;
    color: white;
  }

  .logo {
    line-height: 64px;
  }

  .nav {
    font-size: 0;
  }

  .nav_btn {
    height: 64px;
    padding: 21px 19px;

    &:hover {
      background: rgba(255, 255, 255, 0.15);
    }

    &.router-link-active {
      background: rgba(255, 255, 255, 0.25);
    }
  }
</style>