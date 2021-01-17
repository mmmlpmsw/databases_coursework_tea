<template>
  <div class="factory_page">
    <game-specific-renderer class="renderer"
                            ref="renderer"
                            :class="{ dialog_mode: dialogMode }"
                            :event-bus="eventBus"
                            :area-width="1000"
                            :area-height="1000"
                            :max-fps="40"/>
    <login-dialog :event-bus="eventBus"/>
  </div>
</template>

<script>
  import Vue from 'vue';
  import CameraLayer from "$src/layers/CameraLayer";
  import MouseMovableRenderer from "$src/components/rendering/CameraMovingRenderer";
  import CoordinatesTester from "$src/game/CoordinatesTester";
  import InteractiveObjectsRenderer from "$src/components/rendering/InteractiveObjectsRenderer";
  import AreaTesterBackground from "$src/game/area/AreaTesterBackground";
  import GameSpecificRenderer from "$src/components/rendering/GameSpecificRenderer";
  import AreaThing from "$src/game/area/thing/AreaThing";
  import LoginDialog from '$src/components/LoginDialog';
  import EventBusConstants from "$src/util/EventBusConstants";

  export default {
    data: function() {
      return {
        dialogMode: false,
        eventBus: new Vue(),
        renderer: null
      }
    },
    methods: {
      initGame() {
        this.startEventListening();
      },
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
    created() {
      this.eventBus.$on(EventBusConstants.DIALOG_OPENED, () => this.dialogMode = true);
      this.eventBus.$on(EventBusConstants.DIALOG_CLOSED, () => this.dialogMode = false);
    },
    mounted() {
      this.renderer = this.$refs['renderer'];

      this.startRenderingScene();
    },
    components: {
      GameSpecificRenderer,
      LoginDialog
    }
  }
</script>

<style scoped>
  .factory_page {
    height: 100%;
  }

  .renderer {
    font-size: 0;
    overflow: hidden;
    flex: 1;
  }

  /* used */
  .dialog_mode {
    pointer-events: none;
    filter: brightness(0.8);
  }
</style>