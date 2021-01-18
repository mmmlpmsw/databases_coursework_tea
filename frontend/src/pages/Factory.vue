<template>
  <div class="factory_page">
    <game-specific-renderer class="renderer"
                            ref="renderer"
                            :class="{ dialog_mode: dialogMode }"
                            :event-bus="eventBus"
                            :area-width="1000"
                            :area-height="1000"
                            :max-fps="60"/>
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
  import MachineAreaThing from "$src/game/area/thing/MachineAreaThing";
  import MachineInstancePositionDto from "$src/api/dto/request/MachineInstancePositionDto";
  import MachineInstance from "$src/game/model/MachineInstance";

  export default {
    data: function() {
      return {
        dialogMode: false,
        eventBus: new Vue(),
        renderer: null,
        instanceByAreaThing: {}
      }
    },
    methods: {
      initGame() {
        for (const [key, value] of Object.entries(this.$store.state.game.machineInstances)) {
          let thing = new MachineAreaThing(this.$store, value);
          this.instanceByAreaThing[thing] = value;
          this.renderer.addAreaThing(thing);
        }
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
        let instance = this.instanceByAreaThing[areaThing];
        this.$api.post(
          '/area/position',
          new MachineInstancePositionDto(
            instance.id,
            Math.floor(areaThing.inGameX),
            Math.floor(areaThing.inGameY)
          ),
          () => {
            this.$store.commit("setMachineInstancePosition", {
              instanceId: instance.id,
              x: areaThing.inGameX,
              y: areaThing.inGameY
            })
          },
          (error) => {
            console.error("PANIC!"); // todo
            console.error(error);
            // revert to old position
            areaThing.inGameX = instance.areaX;
            areaThing.inGameY = instance.areaY;
          }
        );
        console.log("Area thing moving requested"); // todo
        console.log(areaThing);
      },
      render() {
        this.eventBus.$emit('render');
        if (!this.dialogMode)
          window.requestAnimationFrame(this.render);
        else
          setTimeout(() => window.requestAnimationFrame(this.render), 150)
      }
    },
    created() {
      this.eventBus.$on(EventBusConstants.DIALOG_OPENED, () => this.dialogMode = true);
      this.eventBus.$on(EventBusConstants.DIALOG_CLOSED, () => this.dialogMode = false);
      this.eventBus.$on(EventBusConstants.LOGGED_IN, this.initGame);
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

<style lang="scss" scoped>
  .factory_page {
    height: 100%;
  }

  .renderer {
    font-size: 0;
    overflow: hidden;
    transition: filter 300ms;
    filter: brightness(1);
    flex: 1;

    /* used */
    &.dialog_mode {
      pointer-events: none;
      filter: brightness(0.75);
    }
  }
</style>