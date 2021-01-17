<template>
  <div  class="interactive_renderer"
        @mousemove="onMouseMove"
        @mousedown="onMouseDown"
        @mouseup="onMouseUp"
        @click="onMouseClick">

    <camera-moving-renderer ref="renderer"
                            :cursor="cursor"
                            :event-bus="eventBus"
                            :root-layer="rootLayer"
                            :camera-layer="cameraLayer"
                            :max-fps="maxFps"/>

  </div>
</template>

<script>
  import CameraMovingRenderer from "$src/components/rendering/CameraMovingRenderer";
  import Vue from "vue";
  import CameraLayer from "$src/layers/CameraLayer";
  import Layer from "$src/layers/Layer";
  import Interactive from "$src/game/Interactive";

  export default {
    components: {
      CameraMovingRenderer
    },
    props: {
      eventBus: Vue,
      rootLayer: Layer,
      interactiveRoot: Interactive,
      cameraLayer: CameraLayer,
      maxFps: Number
    },
    data() {
      return {
        cursor: "default"
      }
    },
    methods: {
      onMouseMove(e) {
        let p = this.cameraLayer.unproject(e.offsetX, e.offsetY);
        this.interactiveRoot.processMouseMove(p.x, p.y);
        this.cursor = this.interactiveRoot.cursor;
      },
      onMouseDown(e) {
        let p = this.cameraLayer.unproject(e.offsetX, e.offsetY);
        this.interactiveRoot.processMouseDown(p.x, p.y);
      },
      onMouseUp(e) {
        let p = this.cameraLayer.unproject(e.offsetX, e.offsetY);
        this.interactiveRoot.processMouseUp(p.x, p.y);
      },
      onMouseClick(e) {
        let p = this.cameraLayer.unproject(e.offsetX, e.offsetY);
        this.interactiveRoot.processMouseClick(p.x, p.y);
      }
    }
  }
</script>

<style>
  .interactive_renderer {
    height: 100%;
  }
</style>