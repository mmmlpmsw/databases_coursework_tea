<template>
  <div  class="mouse_renderer"
        @mousemove="onMouseMove"
        @mousedown="onMouseDown"
        @mouseup="onMouseUp"
        @wheel.prevent="onMouseWheel">
    <basic-objects-renderer ref="renderer" :event-bus="eventBus" :renderables="renderables" :max-fps="maxFps"/>
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
        },
        scrollSensibility: 0.01
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

        this.cameraLayer.cameraX -= dragDiff.x;
        this.cameraLayer.cameraY -= dragDiff.y;

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
      },
      onMouseWheel(e) {
        let rendererCtx = this.$refs.renderer.getContext();
        let cameraX = e.offsetX - rendererCtx.canvas.width/2;
        let cameraY = e.offsetY - rendererCtx.canvas.height/2;
        let origin = this.cameraLayer.unproject(cameraX, cameraY);
        let scaleFactor;
        if (e.deltaY > 0)
          scaleFactor = 1/(1 + e.deltaY*this.scrollSensibility);
        else
          scaleFactor = 1 - e.deltaY*this.scrollSensibility;

        this.cameraLayer.scaleCamera(scaleFactor, origin.x, origin.y);
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