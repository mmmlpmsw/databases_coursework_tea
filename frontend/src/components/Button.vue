<template>
  <button :type="type" @click.prevent="$emit('click')"><slot/></button>
</template>

<script>
  export default {
    props: {
      'type': { default: 'button' },
    }
  }
</script>

<style scoped lang="scss">
  button {
    font-size: 20px;
    padding: 10px 15px;
    border-radius: 4px;
    border: 1px #bbb solid;
    background: white;
    cursor: pointer;
    outline: none;
    user-select: none;

    &:active {
      background: rgb(180, 180, 180);
    }

    &[ghost] {
      border-color: white;
      border-width: 2px;
      background: rgba(255, 255, 255, .25);
    }

    &[disabled] {
      opacity: 0.5;
    }

    &[green] {
      background-color: #adffc3;
      border-color: #82bf91;

      &:active {
        background-color: #79b389;
      }
    }

    &:focus {
      border-color: #5b8565;
    }
  }
</style>
