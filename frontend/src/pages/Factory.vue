<template>
  <div class="factory_page">
    <game-specific-renderer class="renderer"
                            ref="renderer"
                            :class="{ dialog_mode: dialogMode }"
                            :event-bus="eventBus"
                            :area-width="1000"
                            :area-height="1000"
                            :max-fps="60"/>

    <div class="hud_container_wr">
      <container class="hud_container">
        <user-money/>
        <game-hud-button-panel :event-bus="eventBus"/>
      </container>
    </div>

    <shop-dialog :event-bus="eventBus"/>
    <tea-shop-dialog :event-bus="eventBus"/>
    <inventory-dialog :event-bus="eventBus"/>
    <login-dialog :event-bus="eventBus"/>
    <machine-recipes-dialog :event-bus="eventBus"/>
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
  import LoginDialog from '$src/components/dialogs/LoginDialog';
  import EventBusConstants from "$src/util/EventBusConstants";
  import MachineInstancePositionDto from "$src/api/dto/request/MachineInstancePositionDto";
  import MachineInstance from "$src/game/model/MachineInstance";
  import MachineInstanceRemoveRequestDto from "$src/api/dto/request/MachineInstanceRemoveRequestDto";
  import UserMoney from "$src/components/game/UserMoney";
  import Container from "$src/components/Container";
  import Button from "$src/components/Button";
  import GameHudButtonPanel from "$src/components/game/GameHudButtonsPanel"
  import ShopDialog from "$src/components/dialogs/ShopDialog";
  import InventoryDialog from "$src/components/dialogs/InventoryDialog";
  import MachineAreaThingFactory, {MachineAreaThing} from "$src/game/area/thing/MachineAreaThingFactory";
  import BuyMachineRequestDto from "$src/api/dto/request/BuyMachineRequestDto";
  import MachineRecipesDialog from "$src/components/dialogs/MachineRecipesDialog";
  import TeaShopDialog from "$src/components/dialogs/TeaShopDialog";
  import MachineProduceRequestDto from "$src/api/dto/request/MachineProduceRequestDto";
  import TeaInstance from "$src/game/model/TeaInstance";
  import CircuitBoardInstance from "$src/game/model/CircuitBoardInstance";
  import MachineUpdateStateRequestDto from "$src/api/dto/request/MachineUpdateStateRequestDto";

  export default {
    data: function() {
      return {
        dialogMode: false,
        eventBus: new Vue(),
        renderer: null,
      }
    },
    methods: {
      initGame() {
        for (const [key, value] of Object.entries(this.$store.state.game.machineInstances)) {
          let thing = MachineAreaThingFactory.createInstance(key, this.$store);
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
        this.eventBus.$on(EventBusConstants.MACHINE_PURCHASE_CONFIRMED, this.onMachinePurchaseConfirm);
        this.eventBus.$on(EventBusConstants.REQUEST_MACHINE_RECIPE_START, this.onMachineRecipeStartRequest);
      },
      onAreaThingRemovalRequest(areaThing) {
        let instance = areaThing.instance;  // Workaround
        this.renderer.removeAreaThing(areaThing);
        this.$api.post(
          '/area/remove',
          new MachineInstanceRemoveRequestDto(instance.id),
          () => this.$store.commit("removeMachineInstance", instance.id),
          (error) => {
            console.error("PANIC!"); // todo
            console.error(error);
            // revert changes
            this.renderer.addAreaThing(areaThing);
          }
        );
      },
      onAreaThingMovingRequest(areaThing) {
        let instance = areaThing.instance; // Workaround
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
      },
      onMachinePurchaseConfirm(thing, machineId, inGameX, inGameY) {
        this.renderer.addAreaThing(thing);
        this.$store.commit('addUserMoney', -this.$store.state.game.machines[machineId].price);

        this.$api.post(
          '/area/buy',
          new BuyMachineRequestDto(machineId, inGameX, inGameY),
          (response) => {
            thing.instance = response;
            this.$store.commit('addMachineInstance', response);
          },
          (error) => {
            console.error("PANIC!"); // todo
            console.error(error);
            this.renderer.removeAreaThing(thing);
            this.$store.commit('addUserMoney', this.$store.state.game.machines[machineId].price);
          }
        );
      },
      onMachineRecipeStartRequest(instanceId, recipe) {
        this.$api.post(
          '/machine/produce',
          new MachineProduceRequestDto(instanceId, recipe.id),
          (response) => {
            this.$store.commit('setMachineInstanceCurrentRecipeId', {
              instanceId, recipeId: recipe.id, completionTime: response.completion_time
            });
            for (let teaId in recipe.teas)
              this.$store.commit('spendTeaInstance', new TeaInstance(teaId, recipe.teas[teaId]));
          },
          (error) => {
            console.error("PANIC!"); // todo
            console.error(error);
          }
        )
      },
      onMachineStateUpdateRequest(instanceId, circuitBoardModelId, amount) {
        this.$api.post(
          '/machine/update',
          new MachineUpdateStateRequestDto(instanceId),
          () => this.$store.commit('addCircuitBoardInstance', new CircuitBoardInstance(circuitBoardModelId, amount)),
          (error) => {
            console.error("PANIC!"); // todo
            console.error(error);
          }
        );
      },
      render() {
        this.eventBus.$emit('render');
        let things = this.renderer.getAreaThings();
        for (let thing of things) {
          if (thing.instance && thing.instance.currentRecipeId && thing.instance.currentRecipeIdCompletionTime < Date.now()/1000) {
            this.onMachineStateUpdateRequest(thing.instance.id, thing.instance.machineId, this.$store.state.game.machines[thing.instance.machineId].recipes[thing.instance.currentRecipeId].circuitBoardAmount)
            this.$store.commit('setMachineInstanceCurrentRecipeId', {
              instanceId: thing.instance.id,
              recipeId: null,
              completionTime: null
            });
          }
        }
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
      TeaShopDialog,
      MachineRecipesDialog,
      InventoryDialog,
      ShopDialog,
      UserMoney,
      GameSpecificRenderer,
      GameHudButtonPanel,
      LoginDialog,
      Container,
      GameButton: Button
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
      filter: brightness(0.6);
    }
  }

  .hud_container_wr {
    position: fixed;
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;

    pointer-events: none;
    * {
      pointer-events: all;
    }
  }

  .hud_container {
    pointer-events: none;

    * {
      pointer-events: all;
    }
  }
</style>