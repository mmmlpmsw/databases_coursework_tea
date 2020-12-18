<template>
<!--  todo header-->
<!--  todo vue-router-->

  <snake-game/>
  <tetris-game/>
</template>

<script>
  import SnakeGame from "./components/SnakeGame";
  import TetrisGame from "./components/TetrisGame";

  // todo init router
  // todo init i18n
  // todo make preloader
  // todo make global state

  export default {
    components: {
      SnakeGame,
      TetrisGame
    }
  }
</script>

<style>

</style>