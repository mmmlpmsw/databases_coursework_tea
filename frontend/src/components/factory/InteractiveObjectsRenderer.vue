<template>
  <div  class="interactive_renderer"
        @mousemove="onMouseMove"
        @mousedown="onMouseDown"
        @mouseup="onMouseUp"
        @click="onMouseClick">

    <camera-moving-renderer ref="renderer"
                            :event-bus="eventBus"
                            :renderables="renderables"
                            :camera-layer="cameraLayer"
                            :max-fps="maxFps"/>

  </div>
</template>

<script>
  import CameraMovingRenderer from "$src/components/factory/CameraMovingRenderer";
  import Vue from "vue";
  import CameraLayer from "$src/layers/CameraLayer";

  export default {
    components: {
      CameraMovingRenderer
    },
    props: {
      eventBus: Vue,
      renderables: Array,
      interactives: Array,
      cameraLayer: CameraLayer,
      maxFps: Number
    },
    data() {
      return {

      }
    },
    methods: {
      onMouseMove(e) {
        let point = this.cameraLayer.unproject(e.offsetX, e.offsetY);

        this.interactives.forEach(item => {
          if (item.isPointOnItem(point.x, point.y)) {
            if (!item.hover) {
              item.hover = true;
              item.processMouseEnter(point.x, point.y);
            }
            item.processMouseMove(point.x, point.y);
          } else {
            if (item.hover) {
              item.hover = false;
              item.processMouseLeave(point.x, point.y);
            }
          }
        });

      },
      onMouseDown(e) {
        let point = this.cameraLayer.unproject(e.offsetX, e.offsetY);

        this.interactives.forEach(item => {
          if (item.isPointOnItem(point.x, point.y)) {
            item.active = true;
            item.processMouseDown(point.x, point.y);
          }
        });
      },
      onMouseUp(e) {
        let point = this.cameraLayer.unproject(e.offsetX, e.offsetY);

        this.interactives.forEach(item => {
          if (item.isPointOnItem(point.x, point.y)) {
            item.active = false;
            item.processMouseUp(point.x, point.y);
          }
        });
      },
      onMouseClick(e) {
        let point = this.cameraLayer.unproject(e.offsetX, e.offsetY);

        this.interactives.forEach(item => {
          if (item.isPointOnItem(point.x, point.y)) {
            item.processMouseClick(point.x, point.y);
          }
        });
      }
    }
  }
</script>

<style>
  .interactive_renderer {
    height: 100%;
  }
</style>