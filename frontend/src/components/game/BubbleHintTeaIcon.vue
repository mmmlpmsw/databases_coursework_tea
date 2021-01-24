<template>
  <div class="bubble_hint_icon">
    <img class="image" :src="`assets/image/game/teas/id${id}/image.png`" alt="Tea icon">
  </div>
</template>

<script>
  export default {
    props: [ 'id' ]
  }
</script>

<style scoped>
  .image {
    width: 100%;
  }
</style>