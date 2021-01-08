<template>
  <div class="camera_specific_renderer">
    <interactive-objects-renderer :event-bus="eventBus"
                                  :interactive-root="rootInteractive"
                                  :camera-layer="cameraLayer"
                                  :root-layer="rootLayer"
                                  :max-fps="maxFps"/>
  </div>
</template>

<script>
  import InteractiveObjectsRenderer from "$src/components/factory/InteractiveObjectsRenderer.vue";
  import Vue from 'vue';
  import AreaTesterBackground from "$src/game/area/AreaTesterBackground";
  import CameraLayer from "$src/layers/CameraLayer";
  import TesterRenderable from "$src/game/TesterRenderable";
  import AreaThing from "$src/game/area/thing/AreaThing";
  import Layer from "$src/layers/Layer";
  import CompositeInteractive from "$src/game/CompositeInteractive";
  import AreaThingControls from "$src/game/area/thing/controls/AreaThingControls";
  import StaticBackgroundRenderer from "$src/game/StaticBackgroundRenderer";
  import RightWall from "$src/game/area/RightWall";
  import LeftWall from "$src/game/area/LeftWall";

  const STATIC_BACKGROUND = new StaticBackgroundRenderer("rgb(50, 50, 50)");

  let inGameAreaTransformation = new DOMMatrix()
    .scale(1, 0.5)
    .rotate(45);

  /**
   * Rendering layers structure:
   * root
   * - screen-fixed HUD layer
   * - camera Layer
   *    - area HUD layer
   *    - area things layer
   *    - area background layer
   * - static background
   *
   * Interactive layers structure:
   * root
   * - hud layer
   * - things layer
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
        areaThings: [],

        rootInteractive: new CompositeInteractive(),
        thingsInteractive: new CompositeInteractive(),
        hudInteractive: new CompositeInteractive(),

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
      this.rootLayer.addRenderable(STATIC_BACKGROUND);
      this.rootLayer.addRenderable(this.cameraLayer);
      this.rootLayer.addRenderable(this.screenFixedHudLayer);
      this.cameraLayer.addRenderable(this.areaBackgroundLayer);
      this.cameraLayer.addRenderable(this.thingsLayer);
      this.cameraLayer.addRenderable(this.areaHudLayer);

      this.rootInteractive.addInteractive(this.hudInteractive);
      this.rootInteractive.addInteractive(this.thingsInteractive);

      // todo сделать красивый пол, называть его AreaFloor и вставить вместо AreaTesterBackground
      this.areaBackgroundLayer.addRenderable(new AreaTesterBackground(this.areaWidth, this.areaHeight, inGameAreaTransformation));
      this.areaBackgroundLayer.addRenderable(new RightWall()); // todo сделать красивую стенку
      this.areaBackgroundLayer.addRenderable(new LeftWall());

      // For testing purposes
      // let tester = new TesterRenderable();
      // this.areaBackgroundLayer.addRenderable(tester);
      // this.rootInteractive.addInteractive(tester);

      this.eventBus.$on(AreaThing.REQUEST_AREA_THING_CONTROLS_EVENT, this.onRequestAreaThingControls);
    },
    methods: {
      addAreaThing(areaThing) {
        this.thingsLayer.addRenderable(areaThing);
        this.thingsInteractive.addInteractive(areaThing);
        areaThing.eventBus = this.eventBus;
      },
      removeAreaThing(areaThing) {
        areaThing.eventBus = null;
        this.thingsLayer.removeRenderable(areaThing);
        this.thingsInteractive.removeInteractive(areaThing);
      },
      onRequestAreaThingControls(areaThing) {
        let that = this;
        let controls = new AreaThingControls(areaThing, this.eventBus, function() {
          that.areaHudLayer.removeRenderable(this);
          that.hudInteractive.removeInteractive(this);
        });
        controls.hover = true; // Assuming mouse is on the controls object when areaThing clicked
        this.areaHudLayer.addRenderable(controls);
        this.hudInteractive.addInteractive(controls);
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