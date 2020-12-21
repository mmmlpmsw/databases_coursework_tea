<template>
  <mouse-movable-renderer class="renderer"
                          :event-bus="rendererBus"
                          :camera-layer="cameraLayer"
                          :renderables="renderables"
                          :max-fps="60"/>
</template>

<script>
  import Vue from 'vue';
  import CameraLayer from "$src/layers/CameraLayer";
  import MouseMovableRenderer from "$src/components/factory/MouseMovableRenderer";

  export default {
    data: function() {
      return {
        rendererBus: new Vue(),
        cameraLayer: null,
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
      this.cameraLayer = layer;
      window.l = layer; // todo
      this.renderables.push(layer);
    },
    components: {
      MouseMovableRenderer
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