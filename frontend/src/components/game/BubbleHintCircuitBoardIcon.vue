<template>
  <div class="bubble_hint_icon">
    <img class="image" :src="`assets/image/game/circuit_boards/id${id}/image.png`" alt="Circuit board icon">
  </div>
</template>

<script>
  export default {
    props: {
      id: Number,
      amount: Number
    }
  }
</script>

<style scoped>
  .image {
    width: 100%;
  }
</style>