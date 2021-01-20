<template>
  <common-items-dialog  :enabled="enabled" @close-request="closeDialog">
    <template v-slot:header>
      Магазин
    </template>
    <template v-slot:container>

    </template>
    <template v-slot:info>

    </template>
  </common-items-dialog>
</template>

<script>
  import CommonItemsDialog from "$src/components/dialogs/CommonItemsDialog";
  import Vue from 'vue';
  import EventBusConstants from "$src/util/EventBusConstants";

  export default {
    components: { CommonItemsDialog },
    props: {
      eventBus: Vue
    },
    data() {
      return {
        enabled: false
      }
    },
    methods: {
      openDialog() {
        this.enabled = true;
        this.eventBus.$emit(EventBusConstants.DIALOG_OPENED);
      },
      closeDialog() {
        this.enabled = false;
        this.eventBus.$emit(EventBusConstants.DIALOG_CLOSED);
      }
    },
    mounted() {
      this.eventBus.$on(EventBusConstants.REQUEST_SHOP_DIALOG, this.openDialog);
    }
  }
</script>

<style>

</style>