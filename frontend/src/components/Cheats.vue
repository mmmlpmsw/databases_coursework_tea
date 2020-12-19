<template>
  <div>
    <snake-game/>
    <tetris-game/>
  </div>
</template>

<script>
  import SnakeGame from "$src/components/SnakeGame";
  import TetrisGame from "$src/components/TetrisGame";

  export default {
    components: {
      SnakeGame,
      TetrisGame
    }
  }
</script>