<template>
  <div class="bg" @click="onClick">
    <div class="slider" :class="{'to_right': $store.state.darkTheme}"></div>
  </div>
</template>

<script>
  export default {
    methods: {
      onClick() {
        this.$store.commit('switchTheme');
      }
    }
  }
</script>

<style scoped lang="scss">
  .bg {
    background-color: #3d3d3d;
    width: 64px;
    height: 32px;
    border-radius: 16px;
    cursor: pointer;
  }

  .slider {
    width: 32px;
    height: 32px;
    border-radius: 16px;
    background: #9a9a9a;
    margin-left: 0;
    transition: margin-left 300ms;

    &.to_right {
      margin-left: 32px;
    }
  }
</style>