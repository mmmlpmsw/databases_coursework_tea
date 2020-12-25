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
  import MouseMovableRenderer from "$src/components/factory/CameraMovingRenderer";
  import TesterRenderable from "$src/ui/TesterRenderable";

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
      let layer = new CameraLayer();
      layer.renderables.push(new TesterRenderable());
      this.cameraLayer = layer;
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