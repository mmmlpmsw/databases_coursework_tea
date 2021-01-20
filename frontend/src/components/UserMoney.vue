<template>
  <div class="user_money" v-if="$store.state.user">
    <div class="icon_wr">
      <img src="assets/image/game/money_icon.svg" width="40px" alt="Money icon" class="icon">
    </div>
    <span class="money_number">{{ $store.state.user.money }}</span>
  </div>
</template>

<script>
  export default {

  }
</script>

<style scoped>
  .user_money {
    padding: 15px;
    user-select: none;
    display: inline-flex;
    align-items: center;
  }

  .icon_wr {
    display: flex;
    margin-right: 15px;
  }

  .money_number {
    color: white;
    font-size: 36px;
  }
</style>