<template>
  <div class="game_button_panel" v-if="$store.state.user">
    <game-button @click="openShopDialog">Магазин</game-button>
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
      openShopDialog() {
        this.eventBus.$emit(EventBusConstants.REQUEST_SHOP_DIALOG);
      },
      openInventoryDialog() {
        this.eventBus.$emit(EventBusConstants.REQUEST_INVENTORY_DIALOG);
      }
    }
  }
</script>

<style>

</style>