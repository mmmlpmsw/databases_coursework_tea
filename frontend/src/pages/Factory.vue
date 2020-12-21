<template>
  <basic-objects-renderer class="renderer" :event-bus="rendererBus" :renderables="renderables" :max-fps="60"/>
</template>

<script>
  import BasicObjectsRenderer from "$src/components/factory/BasicObjectsRenderer";
  import Vue from 'vue';
  import CameraLayer from "$src/layers/CameraLayer";

  export default {
    data: function() {
      return {
        rendererBus: new Vue(),
        renderables: []
      }
    },
    methods: {
      renderScene() {
        setInterval(() => this.rendererBus.$emit('render'), 0);
      }
    },
    mounted() {
      this.renderScene();
      let obj = {
        render(ctx, idx) {
          ctx.fillStyle = 'black';
          ctx.font = "48px sans-serif";
          ctx.textBaseline = "top";
          ctx.fillText(`Test object index ${idx}`, 1, idx*120);
          ctx.fillText(`Time ${Date.now()}`, 1, idx*120 + 50);
        }
      };
      let arr = [];
      arr.push(obj);
      arr.push(obj);
      arr.push(obj);
      arr.push(obj);
      arr.push(obj);
      arr.push(obj);
      let layer = new CameraLayer(arr);
      window.l = layer;
      this.renderables.push(layer);
    },
    components: {
      BasicObjectsRenderer
    }
  }
</script>

<style>
  .renderer {
    font-size: 0;
    overflow: hidden;
    flex: 1;
  }
</style>