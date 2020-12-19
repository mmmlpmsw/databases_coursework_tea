<template>
  <div class="container"><slot/></div>
</template>

<script>
  export default {}
</script>

<style scoped lang="scss">
  @import "~$src/style/tablet.scss";
  @import "~$src/style/mobile.scss";

  .container {
    max-width: 100%;
    width: 1440px;
    margin: auto;
  }

  @include tablet {
    .container {
      width: 800px;
    }
  }

  @include mobile {
    .container {
      width: calc(165px + 40vw);
    }
  }
</style>
