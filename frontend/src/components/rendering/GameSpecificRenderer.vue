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
  import InteractiveObjectsRenderer from "$src/components/rendering/InteractiveObjectsRenderer.vue";
  import Vue from 'vue';
  import AreaTesterBackground from "$src/game/area/AreaTesterBackground";
  import CameraLayer from "$src/layers/CameraLayer";
  import CoordinatesTester from "$src/game/CoordinatesTester";
  import AreaThing from "$src/game/area/thing/AreaThing";
  import Layer from "$src/layers/Layer";
  import CompositeInteractive from "$src/game/CompositeInteractive";
  import AreaThingControls from "$src/game/area/thing/controls/AreaThingControls";
  import StaticBackgroundRenderer from "$src/game/environment/StaticBackgroundRenderer";
  import {SkyRenderer} from "$src/game/environment/SkyRenderer";
  import StaticBuildingRenderer from "$src/game/area/StaticBuildingRenderer";
  import CloudsRenderer from "$src/game/environment/CloudsRenderer";
  import SwitchingInteractive from "$src/game/SwitchingInteractive";
  import AreaThingMover from "$src/game/area/thing/moving/AreaThingMover";

  let inGameAreaTransformation = new DOMMatrix()
    .scale(1, 0.5)
    .rotate(45);

  /**
   * Rendering layers structure:
   * root
   * - screen-fixed HUD
   * - camera
   *    - front clouds
   *    - area HUD
   *    - area things
   *    - mover
   *    - area background
   *      - area tester background
   *      - static building
   *      - back clouds
   *      - sky
   * - static background
   *
   * Interactive layers structure:
   * root
   * - hud
   * - switchable things
   *    - things
   *    - mover
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
        areaThingMover: null,

        rootInteractive: new CompositeInteractive(),
        thingsInteractive: new CompositeInteractive(),
        switchableThingsInteractive: null,
        hudInteractive: new CompositeInteractive(),

        rootLayer: new Layer(),
        screenFixedHudLayer: new Layer(),
        cameraLayer: new CameraLayer(),
        frontCloudsLayer: new CloudsRenderer(-4000, 4000, 1300, 2000, 10, -0.3, -0.1),
        areaHudLayer: new Layer(),
        thingsLayer: new Layer(),
        areaBackgroundLayer: new Layer(),
        backCloudsLayer: new CloudsRenderer(-8000, 8000, 1300, 2000, 30, 0.01, 0.4),
      }
    },
    mounted() {
      this.areaThingMover = new AreaThingMover(this.eventBus, this.areaThings, inGameAreaTransformation);
      this.cameraLayer.cameraY = 350;

      // Constructing layers structure
      this.rootLayer.addRenderable(this.cameraLayer);
      this.rootLayer.addRenderable(this.screenFixedHudLayer);
      this.cameraLayer.addRenderable(this.areaBackgroundLayer);
      this.cameraLayer.addRenderable(this.areaThingMover);
      this.cameraLayer.addRenderable(this.thingsLayer);
      this.cameraLayer.addRenderable(this.areaHudLayer);
      this.cameraLayer.addRenderable(this.frontCloudsLayer);
      this.areaBackgroundLayer.addRenderable(new SkyRenderer(-30000, -15000, 30000, 15000));
      this.areaBackgroundLayer.addRenderable(this.backCloudsLayer);
      this.areaBackgroundLayer.addRenderable(new StaticBuildingRenderer());
      this.areaBackgroundLayer.addRenderable(new AreaTesterBackground(this.areaWidth, this.areaHeight, inGameAreaTransformation)); // todo сделать красивый пол, называть его AreaFloor и вставить вместо AreaTesterBackground

      this.switchableThingsInteractive = new SwitchingInteractive("default", {
        default: this.thingsInteractive,
        mover: this.areaThingMover
      });

      this.rootInteractive.addInteractive(this.hudInteractive);
      this.rootInteractive.addInteractive(this.switchableThingsInteractive);

      this.eventBus.$on(AreaThing.REQUEST_AREA_THING_CONTROLS_EVENT, this.onRequestAreaThingControls);
      this.eventBus.$on(AreaThing.REQUEST_AREA_THING_MOVING_START_EVENT, this.onRequestAreaThingMovingStart);
      this.eventBus.$on(AreaThing.REQUEST_AREA_THING_MOVING_DONE_EVENT, this.onRequestAreaThingMovingDone);
    },
    methods: {
      addAreaThing(areaThing) {
        this.thingsLayer.addRenderable(areaThing);
        this.thingsInteractive.addInteractive(areaThing);
        this.areaThings.push(areaThing);
        areaThing.eventBus = this.eventBus;
      },
      removeAreaThing(areaThing) {
        areaThing.eventBus = null;
        this.thingsLayer.removeRenderable(areaThing);
        this.thingsInteractive.removeInteractive(areaThing);
        let index = this.areaThings.indexOf(areaThing);
        if (index !== -1)
          this.areaThings.splice(index, 1);
      },
      onRequestAreaThingMovingStart(areaThing) {
        // Workaround
        setTimeout(() => {
          this.switchableThingsInteractive.switch("mover");
          this.thingsLayer.removeRenderable(areaThing);
          this.areaThingMover.move(areaThing);
        }, 0);
      },
      onRequestAreaThingMovingDone(areaThing) {
        this.switchableThingsInteractive.switch("default");
        this.thingsLayer.addRenderable(areaThing);
      },
      onRequestAreaThingControls(areaThing) {
        let that = this;
        let controls = new AreaThingControls(areaThing, this.eventBus, function() {
          that.areaHudLayer.removeRenderable(this);
          that.hudInteractive.removeInteractive(this);
        });
        controls.hover = true; // Assuming mouse is on the controls object when areaThing is clicked
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