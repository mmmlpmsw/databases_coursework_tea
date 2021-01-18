<template>
  <div class="message_panel_wr" :red="red" :green="green" :blue="blue">
    <div class="message_panel">
      <slot></slot>
    </div>
  </div>
</template>

<script>
  export default {
    props: ['red', 'green', 'blue']
  }
</script>

<style scoped lang="scss">
  .message_panel_wr {
    border-width: 1px;
    border-style: solid;
    border-color: #2b2b2b;
    background-color: rgba(255, 255, 255, 1);

    .message_panel{
      padding: 10px;
    }

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
