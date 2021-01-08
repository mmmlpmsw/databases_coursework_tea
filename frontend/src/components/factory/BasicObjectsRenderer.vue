<template>
  <div class="base-renderer">
    <canvas class="canvas" ref="canvas" :style="{ cursor }"/>
  </div>
</template>

<script>
  import { throttle } from 'throttle-debounce';
  import Vue from 'vue';
  import Layer from "$src/layers/Layer";

  export default {
    props: {
      rootLayer: Layer,
      eventBus: Vue,
      maxFps: Number,
      cursor: {
        type: String,
        default: "default"
      }
    },
    data: function() {
      return {
        canvas: null,
        ctx: null,
      }
    },
    methods: {
      render() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        this.rootLayer.render(this.ctx, 0);
      },
      onRenderEvent() {
        throw Error("Got 'render' event but renderer is not initialized");
      },
      askForRender() {
        this.eventBus.$emit('render');
      },
      onWindowResize() {
        this.canvas.width  = this.canvas.parentElement.offsetWidth;
        this.canvas.height = this.canvas.parentElement.offsetHeight;
        this.eventBus.$emit('resize', {
          width: this.canvas.width,
          height: this.canvas.height
        });
        this.askForRender();
      }
    },
    created() {
      window.addEventListener('resize', this.onWindowResize);
      this.onRenderEvent = throttle(1000/this.maxFps, this.render);
    },
    mounted() {
      this.canvas = this.$refs.canvas;
      this.ctx = this.canvas.getContext('2d');

      if (this.eventBus)
        this.eventBus.$on('render', this.onRenderEvent);

      this.onWindowResize();
    },
    beforeDestroy() {
      window.removeEventListener('resize', this.onWindowResize);
    }
  }
</script>

<style>
  .canvas,
  .base-renderer {
    width: 100%;
    height: 100%;
  }
</style>