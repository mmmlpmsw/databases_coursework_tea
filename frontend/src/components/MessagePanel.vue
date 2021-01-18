<template>
  <div class="message_panel" :red="red" :green="green" :blue="blue">
    <slot></slot>
  </div>
</template>

<script>
  export default {
    props: ['red', 'green', 'blue']
  }
</script>

<style scoped lang="scss">
  .message_panel {
    border-width: 1px;
    border-style: solid;
    border-color: #2b2b2b;
    background-color: rgba(255, 255, 255, 1);
    padding: 10px;

    &[red] {
      background-color: rgb(255, 139, 137);
      border-color: #b33131;
    }

    &[green] {
      background-color: rgb(129, 255, 121);
      border-color: #00a50b;
    }

    &[blue] {
      background-color: rgb(146, 193, 255);
      border-color: #005995;
    }
  }
</style>
