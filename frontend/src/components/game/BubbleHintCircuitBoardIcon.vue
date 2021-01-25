<template>
  <div class="bubble_hint_icon">
    <img class="image" :src="`assets/image/game/circuit_boards/id${id}/image.png`" alt="Circuit board icon">
    <div class="icon_amount">{{ amount }}</div>
  </div>
</template>

<script>
  export default {
    props: ['id', 'amount']
  }
</script>

<style scoped>
  .bubble_hint_icon {
    position: relative;
  }

  .image {
    width: 100%;
  }

  .icon_amount {
    color: white;
    position: absolute;
    text-shadow: 0 0 1px black;
    font-size: 32px;
    bottom: 15%;
    right: 15%;
  }
</style>