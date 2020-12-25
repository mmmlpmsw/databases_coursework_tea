<template>
  <div  class="interactive_renderer"
        @mousemove="onMouseMove"
        @mousedown="onMouseDown"
        @mouseup="onMouseUp">
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
        // todo
      },
      onMouseDown(e) {
        // todo
      },
      onMouseUp() {
        // todo
      }
    }
  }
</script>