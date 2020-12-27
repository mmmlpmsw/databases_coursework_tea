<template>
  <interactive-objects-renderer class="renderer"
                                :event-bus="rendererBus"
                                :camera-layer="cameraLayer"
                                :renderables="renderables"
                                :interactives="interactives"
                                :max-fps="60"/>
</template>

<script>
  import Vue from 'vue';
  import CameraLayer from "$src/layers/CameraLayer";
  import MouseMovableRenderer from "$src/components/factory/CameraMovingRenderer";
  import TesterRenderable from "$src/ui/TesterRenderable";
  import TestButton from "$src/ui/TestButton";
  import InteractiveObjectsRenderer from "$src/components/factory/InteractiveObjectsRenderer";

  export default {
    data: function() {
      return {
        rendererBus: new Vue(),
        cameraLayer: null,
        renderables: [],
        interactives: []
      }
    },
    methods: {
      startRenderingScene() {
        setInterval(() => this.rendererBus.$emit('render'), 0);
      }
    },
    mounted() {
      this.startRenderingScene();

      let layer = new CameraLayer();
      layer.renderables.push(new TesterRenderable());
      // layer.interactives.push(new TestButton(100, 100));
      this.cameraLayer = layer;
      this.renderables.push(layer);
    },
    components: {
      InteractiveObjectsRenderer,
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