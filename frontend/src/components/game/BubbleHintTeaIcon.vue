<template>
  <div class="bubble_hint_icon">
    <img class="image" :src="`assets/image/game/teas/id${id}/image.png`" alt="Tea icon">
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
    text-shadow: 0 0 4px black;
    font-size: 32px;
    position: absolute;
    bottom: 15%;
    right: 15%;
  }
</style>