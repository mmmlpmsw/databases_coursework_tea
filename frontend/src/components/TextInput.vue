<template>
  <label class="wrapper">
    <span class="input_hint"
          v-if="hint"
          :class="{'jump': focused || localText !== ''}">
      {{ hint }}
    </span>

    <span class="input_visual"
          :class="{focused}"
          :state-wrong="errorHint != null">

      <span class="input_wr">
        <span class="input_prefix" v-if="prefix">
          {{ prefix }}
        </span>
        <input  class="input"
                :type="type ? type : 'text'"
                v-model="localText"
                @focus="focused = true"
                @blur="focused = false"
                @keydown.esc="$event.target.blur()">
      </span>

      <span class="ending_wr">
        <slot name="ending"/>
      </span>

    </span>

    <transition-expand>
      <div class="err_msg" v-if="errorHint != null">
        {{ errorHint }}
      </div>
    </transition-expand>
  </label>
</template>

<script>
  import TransitionExpand from "$src/components/TransitionExpand";

  export default {
    components: { TransitionExpand },
    props: ['hint', 'value', 'prefix', 'errorHint', 'type'],
    data() {
      return {
        localText: '',
        focused: false
      }
    },
    watch: {
      value() {
        this.localText = this.value;
      },
      localText() {
        this.$emit('input', this.localText);
      }
    }
  }
</script>

<style lang="scss" scoped>
  .wrapper {
    margin-bottom: 10px;
    margin-top: -10px;
    display: inline-block;
  }

  .input_wr {
    flex: 1;
    display: flex;
    padding: 10px;
    font-size: 16px;
    position: relative;
    justify-content: flex-start;
  }

  .input_visual {
    width: 100%;
    display: flex;
    border-radius: 4px;
    border: 1px #bbb solid;
    transition: border 300ms, box-shadow 300ms;
    background: white;
    cursor: text;

    &.focused {
      border-color: black
    }
  }

  .input_prefix {
    opacity: .5;
    font-size: 16px;
  }

  .input {
    border: none;
    background: none;
    outline: none;
    font-size: 16px;
    width: 100%;
    padding: 0;
    flex: 1;
  }

  .input_hint {
    color: #585858;
    background: white;
    position: relative;
    transition: top 300ms;
    border-radius: 99px;
    top: 30px;
    left: 8px;
    padding: 5px;

    &.jump {
      top: 9px;
      color: black
    }
  }

  [state-wrong='true'] {
    border: 1px solid rgba(255, 0, 0, .5);
    /*box-shadow: 0 0 2px red;*/
  }

  .err_msg {
    color: darkred;
  }
</style>
