<template>
  <button :type="type" @click="$emit('click')"><slot/></button>
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
      border: 1px #82bf91 solid;

      &:active {
        background-color: #79b389;
      }
    }
  }
</style>
