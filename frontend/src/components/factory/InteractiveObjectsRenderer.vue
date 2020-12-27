<template>
  <div  class="interactive_renderer"
        @mousemove="onMouseMove"
        @mousedown="onMouseDown"
        @mouseup="onMouseUp"
        @click="onMouseClick">
    <camera-moving-renderer ref="renderer" :event-bus="eventBus" :renderables="renderables" :camera-layer="cameraLayer" :max-fps="maxFps"/>
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
        let rendererCtx = this.$refs.renderer.getContext();
        let point = this.cameraLayer.unproject(
          e.offsetX - rendererCtx.canvas.width/2,
          e.offsetY - rendererCtx.canvas.height/2
        );

        this.interactives.forEach(function(item, index, array) {
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
        // todo
      },
      onMouseUp() {
        // todo
      },
      onMouseClick() {
        // todo
      }
    }
  }
</script>