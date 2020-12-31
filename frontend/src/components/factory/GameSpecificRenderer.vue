<template>
  <div class="camera_specific_renderer">
    <interactive-objects-renderer :event-bus="eventBus"
                                  :interactives="interactives"
                                  :camera-layer="cameraLayer"
                                  :renderables="renderables"
                                  :max-fps="maxFps"/>
  </div>
</template>

<script>
  import InteractiveObjectsRenderer from "$src/components/factory/InteractiveObjectsRenderer.vue";
  import Vue from 'vue';
  import AreaBackground from "$src/ui/area/AreaBackground";
  import CameraLayer from "$src/layers/CameraLayer";
  import TesterRenderable from "$src/ui/TesterRenderable";
  import AreaThing from "$src/ui/area/AreaThing";

  let inGameAreaTransformation = new DOMMatrix()
    .scale(1, 0.5)
    .rotate(45);

  export default {
    props: {
      eventBus: Vue,
      maxFps: Number,
      areaWidth: Number,
      areaHeight: Number,
      areaThings: Array
    },
    data: function() {
      return {
        renderables: [],
        interactives: [],
        cameraLayer: new CameraLayer(this.renderables)
      }
    },
    mounted() {
      let layer = new CameraLayer();
      layer.renderables.push(new AreaBackground(this.areaWidth, this.areaHeight, inGameAreaTransformation));
      layer.renderables.push(new TesterRenderable());
      this.cameraLayer = layer;
      this.renderables.push(layer);

      let test = new AreaThing(200, 200, 120, 120);
      layer.renderables.push(test);
      this.interactives.push(test);
    },
    components: {
      InteractiveObjectsRenderer
    }
  }
</script>

<style>
  .camera_specific_renderer {
    height: 100%;
  }
</style>