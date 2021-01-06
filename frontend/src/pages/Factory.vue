<template>
  <game-specific-renderer class="renderer"
                                ref="renderer"
                                :event-bus="rendererBus"
                                :area-width="1000"
                                :area-height="1000"
                                :max-fps="60"/>
</template>

<script>
  import Vue from 'vue';
  import CameraLayer from "$src/layers/CameraLayer";
  import MouseMovableRenderer from "$src/components/factory/CameraMovingRenderer";
  import TesterRenderable from "$src/game/TesterRenderable";
  import TestButton from "$src/game/TestButton";
  import InteractiveObjectsRenderer from "$src/components/factory/InteractiveObjectsRenderer";
  import AreaBackground from "$src/game/area/AreaBackground";
  import GameSpecificRenderer from "$src/components/factory/GameSpecificRenderer";
  import AreaThing from "$src/game/area/thing/AreaThing";

  export default {
    data: function() {
      return {
        rendererBus: new Vue(),
        renderer: null
      }
    },
    methods: {
      startRenderingScene() {
        this.render();
      },
      render() {
        this.rendererBus.$emit('render');
        window.requestAnimationFrame(this.render);
      }
    },
    mounted() {
      this.startRenderingScene();

      this.renderer = this.$refs['renderer'];
      this.renderer.addAreaThing(new AreaThing(200, 200, 120, 120));
      this.renderer.addAreaThing(new AreaThing(350, 450, 120, 220));
      this.renderer.addAreaThing(new AreaThing(350, 200, 100, 100));
      // window.test1 = test; // todo
      // window.test2 = test2; // todo
      // window.test3 = test3; // todo
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