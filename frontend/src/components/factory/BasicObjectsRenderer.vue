<template>
  <canvas ref="canvas" class="base-renderer"/>
</template>

<script>
  import { throttle } from 'throttle-debounce';
  import Vue from 'vue';

  export default {
    props: {
      renderables: Array,
      eventBus: Vue,
      maxFps: Number
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
        for (let i = 0, n = this.renderables.length; i < n; i++)
          this.renderables[i].render(this.ctx, i);
      },
      onRenderEvent() {
        throw Error("Got 'render' event but renderer is not initialized");
      },
      askForRender() {
        this.eventBus.$emit('render');
      },
      onWindowResize() {
        this.canvas.width  = window.innerWidth;
        this.canvas.height = window.innerHeight;
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