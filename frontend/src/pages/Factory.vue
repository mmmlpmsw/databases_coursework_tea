<template>
  <basic-objects-renderer class="renderer" :event-bus="rendererBus" :renderables="renderables" :max-fps="60"/>
</template>

<script>
  import BasicObjectsRenderer from "$src/components/factory/BasicObjectsRenderer";
  import Vue from 'vue';

  export default {
    data: function() {
      return {
        rendererBus: new Vue(),
        renderables: [

        ]
      }
    },
    methods: {
      renderScene() {
        setInterval(() => this.rendererBus.$emit('render'), 0);
      }
    },
    mounted() {
      this.renderScene();
      let obj = {
        render(ctx, idx) {
          ctx.fillStyle = 'black';
          ctx.font = "48px sans-serif";
          ctx.textBaseline = "top";
          ctx.fillText(`Test object index ${idx}`, 1, idx*120);
          ctx.fillText(`Time ${Date.now()}`, 1, idx*120 + 50);
        }
      };
      this.renderables.push(obj);
      this.renderables.push(obj);
      this.renderables.push(obj);
      this.renderables.push(obj);
      this.renderables.push(obj);
      this.renderables.push(obj);
      this.renderables.push(obj);
      this.renderables.push(obj);
    },
    components: {
      BasicObjectsRenderer
    }
  }
</script>

<style>
  .renderer {
    width: 100%;
    height: 100%;
  }
</style>