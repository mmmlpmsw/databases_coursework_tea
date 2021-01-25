<template>
  <common-items-dialog :enabled="enabled" @close-request="closeDialog">
    <template v-slot:header>
      Рецепты
    </template>
    <template v-slot:container>
      <div class="recipes" v-if="machine">
        <div class="recipe" v-for="recipe in machine.recipes" :key="recipe.id">
          <div class="recipe_body">
            <div class="recipe_ingredients">
              <bubble-hint-tea-icon class="recipe_ingredient" v-for="(ingredient, amount) in recipe.teas" :key="ingredient.id" :id="ingredient" :amount="amount"/>
            </div>
            <div class="recipe_arrow">
              <img class="recipe_arrow_icon" src="assets/image/game/shop/right_arrow.svg" alt="Right arrow icon">
            </div>
            <bubble-hint-circuit-board-icon class="recipe_result" :id="recipe.circuitBoardId" :amount="recipe.circuitBoardAmount"/>
          </div>
          <div class="recipe_footer">
            <div class="recipe_cost" v-if="recipe.price !== 0">
<!--                  TODO отдельный компонент-->
              <div class="price">
                <div class="money_icon_wrapper">
                  <img class="money_icon" src="assets/image/game/money_icon.svg">
                </div>
                {{ recipe.price }}
              </div>
            </div>
            <div class="recipe_time">
              {{ recipeTimeCost(recipe.workTime) }}
            </div>
            <div class="recipe_make" v-if="!instance.currentRecipeId">
              <game-button green @click="onMakeRecipeRequest(recipe.id)">Произвести</game-button>
            </div>
            <div class="recipe_work_until" v-else-if="instance.currentRecipeId === recipe.id">
              Выполнится через: {{ recipeTimeCost(instance.currentRecipeIdCompletionTime.getDate() - currentTimeMillisReactive) }}
            </div>
            <div class="recipe_other_recipe_hint" v-else>
              Сейчас выполняется другой рецепт
            </div>
          </div>
        </div>
      </div>
    </template>
    <template v-slot:info>
      <div class="info_wrapper" v-if="instance && machine">
        <div class="image" :style="{ backgroundImage: `url('assets/image/game/area/things/id${instance.machineId}/0.png')` }"></div>
        <div class="title">{{ machine.name }}</div>
      </div>
    </template>
  </common-items-dialog>
</template>

<script>
  import Vue from 'vue';
  import EventBusConstants from "$src/util/EventBusConstants";
  import CommonItemsDialog from "$src/components/dialogs/CommonItemsDialog";
  import BubbleHintTeaIcon from "$src/components/game/BubbleHintTeaIcon"
  import BubbleHintCircuitBoardIcon from "$src/components/game/BubbleHintCircuitBoardIcon"
  import Button from "$src/components/Button"

  export default {
    components: { CommonItemsDialog, BubbleHintTeaIcon, BubbleHintCircuitBoardIcon, 'game-button': Button },
    props: {
      eventBus: Vue
    },
    data() {
      return {
        enabled: false,
        currentTimeMillisReactive: null,
        currentInstanceId: null
      }
    },
    computed: {
      instance() {
        return this.$store.state.game.machineInstances[this.currentInstanceId];
      },
      machine() {
        return this.$store.state.game.machines[this.instance.machineId];
      },
      recipeTimeCost() {
        return seconds => {
          let minutes = Math.floor(seconds/60);
          let hours = Math.floor(minutes/60);
          let result = seconds%60 + 'с';

          if (minutes !== 0)
            result = minutes%60 + 'м ';

          if (hours !== 0)
            result = hours + 'ч ';

          return result
        }
      }
    },
    methods: {
      onRecipeDialogRequest(instanceId) {
        this.enabled = true;
        this.currentInstanceId = instanceId;
        this.eventBus.$emit(EventBusConstants.DIALOG_OPENED);
      },
      onRender() {
        this.currentTimeMillisReactive = Date.now();
      },
      onMakeRecipeRequest(recipeId) {
        this.eventBus.$emit(EventBusConstants.REQUEST_MACHINE_RECIPE_START, this.currentInstanceId, recipeId);
        this.closeDialog();
      },
      closeDialog() {
        this.enabled = false;
        this.currentInstanceId = null;
        this.eventBus.$emit(EventBusConstants.DIALOG_CLOSED);
      },
    },
    mounted() {
      this.eventBus.$on(EventBusConstants.REQUEST_MACHINE_RECIPES_DIALOG, this.onRecipeDialogRequest);
      this.eventBus.$on('render', this.onRender);
    },
    beforeDestroy() {
      this.eventBus.$on('render', null);
    }
  }
</script>

<style scoped lang="scss">
  .recipes {

    .recipe {
      background: rgb(224 224 224);
      border-radius: 5px;
      margin-bottom: 10px;
    }

    .recipe_body {
      display: flex;
      justify-content: center;
    }

    .recipe_ingredients {
      display: flex;
      align-items: center;

      .recipe_ingredient {
        padding: 10px;
        flex: 1;
        max-width: 175px;
      }
    }

    .recipe_result {
      display: flex;
      align-items: center;
      padding: 10px;
      max-width: 175px;
    }

    .recipe_arrow {
      display: flex;
    }

    .recipe_arrow_icon {
      width: 50px;
    }

    .recipe_footer {
      padding: 5px 12px;
      border-top: 1px solid #d2d2d2;
      display: flex;
      flex-direction: row;
      align-items: center;
      justify-content: space-around;

      .price {
        display: flex;

        .money_icon_wrapper {
          margin-right: 4px;
          display: flex;

          .money_icon {
            width: 20px;
          }
        }
      }

      .recipe_time {
        color: grey;
      }
    }
  }

  .info_wrapper {
    .image {
      padding-top: 100%;
      position: relative;
      background-size: contain;
      background-position: center;
      background-repeat: no-repeat;
    }

    .title {
      font-size: 24px;
    }
  }
</style>