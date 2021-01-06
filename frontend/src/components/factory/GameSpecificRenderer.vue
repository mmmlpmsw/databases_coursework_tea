<template>
  <div class="camera_specific_renderer">
    <interactive-objects-renderer :event-bus="eventBus"
                                  :interactives="interactives"
                                  :camera-layer="cameraLayer"
                                  :root-layer="rootLayer"
                                  :max-fps="maxFps"/>
  </div>
</template>

<script>
  import InteractiveObjectsRenderer from "$src/components/factory/InteractiveObjectsRenderer.vue";
  import Vue from 'vue';
  import AreaBackground from "$src/game/area/AreaBackground";
  import CameraLayer from "$src/layers/CameraLayer";
  import TesterRenderable from "$src/game/TesterRenderable";
  import AreaThing from "$src/game/area/AreaThing";
  import Layer from "$src/layers/Layer";

  let inGameAreaTransformation = new DOMMatrix()
    .scale(1, 0.5)
    .rotate(45);

  /**
   * Layers structure:
   * root
   * - screen-fixed HUD layer
   * - camera Layer
   *    - area HUD layer
   *    - area things layer
   *    - area background layer
   */
  export default {
    props: {
      eventBus: Vue,
      maxFps: Number,
      areaWidth: Number,
      areaHeight: Number
    },
    data: function() {
      return {
        interactives: [],
        areaThings: [],

        rootLayer: new Layer(),
        thingsLayer: new Layer(),
        areaHudLayer: new Layer(),
        areaBackgroundLayer: new Layer(),
        screenFixedHudLayer: new Layer(),
        cameraLayer: new CameraLayer()
      }
    },
    mounted() {
      // Constructing layers structure
      this.rootLayer.addRenderable(this.cameraLayer);
      this.rootLayer.addRenderable(this.screenFixedHudLayer);
      this.cameraLayer.addRenderable(this.areaBackgroundLayer);
      this.cameraLayer.addRenderable(this.thingsLayer);
      this.cameraLayer.addRenderable(this.areaHudLayer);

      this.areaBackgroundLayer.addRenderable(new AreaBackground(this.areaWidth, this.areaHeight, inGameAreaTransformation));
      this.areaBackgroundLayer.addRenderable(new TesterRenderable()); // todo

      this.eventBus.$on(AreaThing.REQUEST_AREA_THING_CONTROLS_EVENT, this.onRequestAreaThingControls);
    },
    methods: {
      addAreaThing(areaThing) {
        this.thingsLayer.addRenderable(areaThing);
        this.interactives.push(areaThing);
        areaThing.eventBus = this.eventBus;
      },
      removeAreaThing(areaThing) {
        areaThing.eventBus = null;
        this.thingsLayer.removeRenderable(areaThing);
        let index = this.interactives.indexOf(areaThing);
        if (index !== -1)
          this.interactives.splice(index, 1);
      },
      onRequestAreaThingControls(areaThing) {
        // todo
        console.log("on request area thing controls");
        console.log(areaThing);
      }
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