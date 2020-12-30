<template>
  <game-specific-renderer class="renderer"
                                :event-bus="rendererBus"
                                :area-width="1000"
                                :area-height="1000"
                                :max-fps="60"/>
</template>

<script>
  import Vue from 'vue';
  import CameraLayer from "$src/layers/CameraLayer";
  import MouseMovableRenderer from "$src/components/factory/CameraMovingRenderer";
  import TesterRenderable from "$src/ui/TesterRenderable";
  import TestButton from "$src/ui/TestButton";
  import InteractiveObjectsRenderer from "$src/components/factory/InteractiveObjectsRenderer";
  import AreaBackground from "$src/ui/area/AreaBackground";
  import GameSpecificRenderer from "$src/components/factory/GameSpecificRenderer";

  export default {
    data: function() {
      return {
        rendererBus: new Vue()
      }
    },
    methods: {
      startRenderingScene() {
        setInterval(() => this.rendererBus.$emit('render'), 0);
      }
    },
    mounted() {
      this.startRenderingScene();
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