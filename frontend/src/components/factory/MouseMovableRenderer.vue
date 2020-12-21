<template>
  <div  class="mouse_renderer"
        @mousemove="onMouseMove"
        @mousedown="onMouseDown"
        @mouseup="onMouseUp">
    <basic-objects-renderer :event-bus="eventBus" :renderables="renderables" :max-fps="maxFps"/>
  </div>
</template>

<script>
  import BasicObjectsRenderer from "$src/components/factory/BasicObjectsRenderer";
  import Vue from 'vue';
  import Stores from "$src/pages/Stores";
  import CameraLayer from "$src/layers/CameraLayer";

  export default {
    props: {
      eventBus: Vue,
      renderables: Array,
      cameraLayer: CameraLayer,
      maxFps: Number
    },
    data() {
      return {
        dragging: false,
        dragStart: {
          x: 0, y: 0
        }
      }
    },
    methods: {
      onMouseMove(e) {
        if (!this.dragging)
          return;

        this.cameraLayer.setCameraPosition(this.dragStart.x + -e.offsetX, this.dragStart.y + -e.offsetY);
      },
      onMouseDown(e) {
        let point = this.cameraLayer.unproject(e.offsetX, e.offsetY);
        this.dragStart.x = point.x;
        this.dragStart.y = point.y;
        this.dragging = true;
      },
      onMouseUp(e) {
        this.dragging = false;
      }
    },
    components: {
      Stores,
      BasicObjectsRenderer
    }
  }
</script>

<style>
  .mouse_renderer {
    width: 100%;
    height: 100%;
  }
</style>