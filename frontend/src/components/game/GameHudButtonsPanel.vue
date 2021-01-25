<template>
  <div class="game_button_panel" v-if="$store.state.user">
    <game-button @click="openMachineShopDialog">Магазин машин</game-button>
    <game-button @click="openTeaShopDialog">Магазин чаёв</game-button>
    <game-button @click="openInventoryDialog">Инвентарь</game-button>
  </div>
</template>

<script>
  import Vue from 'vue';
  import Button from "$src/components/Button";
  import EventBusConstants from "$src/util/EventBusConstants";

  export default {
    components: { GameButton: Button },
    props: {
      eventBus: Vue
    },
    methods: {
      openMachineShopDialog() {
        this.eventBus.$emit(EventBusConstants.REQUEST_MACHINE_SHOP_DIALOG);
      },
      openTeaShopDialog() {
        this.eventBus.$emit(EventBusConstants.REQUEST_TEA_SHOP_DIALOG);
      },
      openInventoryDialog() {
        this.eventBus.$emit(EventBusConstants.REQUEST_INVENTORY_DIALOG);
      }
    }
  }
</script>

<style>

</style>