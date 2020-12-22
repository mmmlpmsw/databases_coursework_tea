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
        dragBufferPoint: {
          x: 0, y: 0
        }
      }
    },
    methods: {
      onMouseMove(e) {
        if (!this.dragging)
          return;

        let scale = this.cameraLayer.cameraScale;
        let dragDiff = {
          x: scale*(e.offsetX - this.dragBufferPoint.x),
          y: scale*(e.offsetY - this.dragBufferPoint.y)
        };

        this.cameraLayer.moveCamera(
          -dragDiff.x, -dragDiff.y
        );

        this.dragBufferPoint.x = e.offsetX;
        this.dragBufferPoint.y = e.offsetY;
      },
      onMouseDown(e) {
        this.dragBufferPoint.x = e.offsetX;
        this.dragBufferPoint.y = e.offsetY;
        this.dragging = true;
      },
      onMouseUp() {
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