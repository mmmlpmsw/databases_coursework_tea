<template>
  <game-specific-renderer class="renderer"
                                ref="renderer"
                                :event-bus="eventBus"
                                :area-width="1000"
                                :area-height="1000"
                                :max-fps="60"/>
</template>

<script>
  import Vue from 'vue';
  import CameraLayer from "$src/layers/CameraLayer";
  import MouseMovableRenderer from "$src/components/factory/CameraMovingRenderer";
  import CoordinatesTester from "$src/game/CoordinatesTester";
  import InteractiveObjectsRenderer from "$src/components/factory/InteractiveObjectsRenderer";
  import AreaTesterBackground from "$src/game/area/AreaTesterBackground";
  import GameSpecificRenderer from "$src/components/factory/GameSpecificRenderer";
  import AreaThing from "$src/game/area/thing/AreaThing";

  export default {
    data: function() {
      return {
        eventBus: new Vue(),
        renderer: null
      }
    },
    methods: {
      startRenderingScene() {
        this.render();
      },
      startEventListening() {
        this.eventBus.$on(AreaThing.REQUEST_AREA_THING_REMOVAL_EVENT, this.onAreaThingRemovalRequest);
        this.eventBus.$on(AreaThing.REQUEST_AREA_THING_MOVING_DONE_EVENT, this.onAreaThingMovingRequest);
      },
      onAreaThingRemovalRequest(areaThing) {
        this.renderer.removeAreaThing(areaThing);
        // todo message for server
      },
      onAreaThingMovingRequest(areaThing) {
        // todo сюда должны прийти готовые координаты и отправка на сервер. предполагается, что areaThing уже сдвинут в нужное место
        console.log("Area thing moving requested"); // todo
        console.log(areaThing);
      },
      render() {
        this.eventBus.$emit('render');
        window.requestAnimationFrame(this.render);
      }
    },
    mounted() {
      this.renderer = this.$refs['renderer'];

      this.startRenderingScene();
      this.startEventListening();

      // todo get area things from server
      let things = [
        new AreaThing(200, 200, 120, 120),
        new AreaThing(350, 450, 120, 220),
        new AreaThing(350, 200, 100, 100)
      ];
      things.forEach(this.renderer.addAreaThing);
    },
    components: {
      GameSpecificRenderer
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