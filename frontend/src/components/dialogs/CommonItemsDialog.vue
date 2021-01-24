<template>
  <div class="common_dialog_wrapper" @click="onWrapperClick" v-if="enabled">
    <div class="common_dialog">

      <div class="dialog_header">
        <slot name="header"/>
      </div>

      <div class="dialog_content">
        <div class="items_container">
          <slot name="container"/>
        </div>
        <div class="item_info">
          <slot name="info"/>
        </div>
      </div>

      <div class="close_hint">
        Кликните за пределами диалога или нажмите Escape, чтобы выйти
      </div>

    </div>
  </div>
</template>

<script>
  export default {
    props: {
      enabled: Boolean
    },
    methods: {
      onWrapperClick(event) {
        if (event.target.classList.contains("common_dialog_wrapper")) {
          this.requestClosing();
        }
      },
      requestClosing() {
        if (this.enabled)
          this.$emit("close-request");
      },
      onGlobalKeyPress(event) {
        if (event.keyCode === 27) // Escape
          this.requestClosing();
      }
    },
    mounted() {
      document.body.addEventListener('keydown', this.onGlobalKeyPress);
    },
    beforeDestroy() {
      document.body.removeEventListener('keydown', this.onGlobalKeyPress);
    }
  }
</script>

<style scoped lang="scss">
  .common_dialog_wrapper {
    pointer-events: all;
    position: fixed;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .common_dialog {
    border-radius: 10px;
    box-shadow: 0 0 50px rgba(0, 0, 0, 0.25);
    background: white;
    height: 700px;
    width: calc(20vw + 650px);
    display: flex;
    position: relative;
    flex-direction: column;

    .dialog_header {
      padding: 20px;
      border-bottom: 1px #e0e0e0 solid;
    }

    .dialog_content {
      border-radius: 10px;
      overflow: hidden;
      display: flex;
      flex: 1;

      .items_container {
        background-color: #f3f3f3;
        overflow-y: auto;
        padding: 20px;
        flex: 1;
      }

      .item_info {
        box-sizing: content-box;
        overflow-y: auto;
        background-color: #f9f9f9;
        border-left: 1px solid #e8e8e8;
        padding: 20px;
        width: 300px;
      }
    }
  }

  .close_hint {
    text-align: center;
    position: absolute;
    bottom: -30px;
    color: white;
    width: 100%;
    opacity: 0.5;
  }
</style>