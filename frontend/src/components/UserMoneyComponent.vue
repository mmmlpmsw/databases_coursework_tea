<template>
    <div v-if="this.$store.state.user !== null">
      <p>
        {{this.$store.state.user.login}}
        {{this.$store.state.user.money}}
      </p>

    </div>
</template>

<script>
    export default {
        name: "UserMoneyComponent",
    }
</script>

<style scoped>
  div {
    font-size: 16px;
  }
</style>