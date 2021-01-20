<template>
  <div v-if="this.$store.state.user">
    <p>
      {{this.$store.state.user.login}}
      {{this.$store.state.user.money}}
    </p>
  </div>
</template>

<script>
  export default {

  }
</script>

<style scoped>
  div {
    font-size: 16px;
  }
</style>