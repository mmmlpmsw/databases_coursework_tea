<template>
  <common-items-dialog  :enabled="enabled" @close-request="closeDialog">
    <template v-slot:header>
      Магазин
    </template>
    <template v-slot:container>
      <div class="items">

        <div  class="item"
              v-for="item in $store.state.game.machines"
              :class="{
                too_expensive: item.price > $store.state.user.money,
                selected: selectedItem === item
              }"
              @click="selectedItem = item">
          <div class="image" :style="{ backgroundImage: `url('assets/image/game/area/things/id${item.id}/0.png')` }"></div>
          <div class="title">{{ item.name }}</div>
          <div class="price">
            <div class="money_icon_wrapper">
              <img class="money_icon" src="assets/image/game/money_icon.svg">
            </div>
            {{ item.price }}
          </div>
        </div>

      </div>
    </template>
    <template v-slot:info>
      <div class="item_info_wrapper" v-if="selectedItem">
        <div class="item_info_scrollable">
          <div class="image" :style="{ backgroundImage: `url('assets/image/game/area/things/id${selectedItem.id}/0.png')` }"></div>
          <div class="title">{{ selectedItem.name }}</div>
          <div class="recipes">
            <div class="recipes_title">Может произвести</div>
            <div class="recipe" v-for="recipe in selectedItem.recipes" :key="recipe.id">
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
              </div>
            </div>
          </div>
        </div>
        <div class="item_info_bottom">
          <game-button green class="item_info_buy_button" v-if="selectedItem.price <= $store.state.user.money">
            Приобрести за
<!--            TODO отдельный компонент-->
            <div class="price">
              <div class="money_icon_wrapper">
                <img class="money_icon" src="assets/image/game/money_icon.svg">
              </div>
              {{ selectedItem.price }}
            </div>
          </game-button>
          <div v-else class="item_info_too_expensive">
            Недостаточно тикоинов, чтобы приобрести
          </div>
        </div>
      </div>
      <div v-else class="item_info_placeholder_wrapper">
        <div class="item_info_placeholder">
          Выберите элемент слева
        </div>
      </div>
    </template>
  </common-items-dialog>
</template>

<script>
  import CommonItemsDialog from "$src/components/dialogs/CommonItemsDialog";
  import Vue from 'vue';
  import EventBusConstants from "$src/util/EventBusConstants";
  import Button from '$src/components/Button'
  import BubbleHintCircuitBoardIcon from "$src/components/game/BubbleHintCircuitBoardIcon";
  import BubbleHintTeaIcon from "$src/components/game/BubbleHintTeaIcon";

  export default {
    components: {BubbleHintTeaIcon, BubbleHintCircuitBoardIcon, CommonItemsDialog, GameButton: Button },
    props: {
      eventBus: Vue
    },
    data() {
      return {
        enabled: false,
        selectedItem: null
      }
    },
    computed: {
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
      openDialog() {
        this.enabled = true;
        this.eventBus.$emit(EventBusConstants.DIALOG_OPENED);
      },
      closeDialog() {
        this.enabled = false;
        this.eventBus.$emit(EventBusConstants.DIALOG_CLOSED);
      }
    },
    mounted() {
      this.eventBus.$on(EventBusConstants.REQUEST_SHOP_DIALOG, this.openDialog);
    }
  }
</script>

<style scoped lang="scss">
  .items {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(175px, 1fr));
  }

  .item {
    cursor: pointer;
    padding: 10px;
    user-select: none;
    border-radius: 4px;

    &:hover {
      background: #e5e5e5;
    }

    &.too_expensive {
      opacity: .5;
    }

    &.selected {
      background: #d4d4d4;
    }

    .image {
      padding-top: 100%;
      position: relative;
      background-size: contain;
      background-position: center;
      background-repeat: no-repeat;
    }

    .title {
      margin: 8px 0;
      overflow: hidden;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-line-clamp: 2; /* number of lines to show */
      -webkit-box-orient: vertical;
    }

    .price {
      font-size: 18px;
      display: flex;
    }

    .money_icon_wrapper {
      display: flex;
      margin-right: 5px;
    }

    .money_icon {
      width: 22px;
    }
  }

  .item_info_placeholder_wrapper {
    display: flex;
    height: 100%;
    user-select: none;
    align-items: center;
    justify-content: center;
  }

  .item_info_placeholder {
    color: grey;
  }

  .item_info_wrapper {
    min-height: 100%;
    flex-direction: column;
    display: flex;

    .item_info_scrollable {
      flex: 1;

      .image {
        padding-top: 100%;
        position: relative;
        background-size: contain;
        background-position: center;
        background-repeat: no-repeat;
      }

      .title {
        font-size: 24px;
        margin: 10px 0;
      }
    }

    .item_info_buy_button {
      margin-top: 10px;
      width: 100%;

      .price {
        font-size: 24px;
        display: flex;
        justify-content: center;

        .money_icon_wrapper {
          display: flex;
          margin-right: 5px;

          .money_icon {
            width: 22px;
          }
        }
      }
    }

    .item_info_too_expensive {
      text-align: center;
      margin: 10px 0;
      color: grey;
    }
  }

  .recipes_title {
    text-align: center;
    text-transform: uppercase;
    color: grey;
    margin-bottom: 5px;
  }

  .recipe {
    background-color: rgb(228 228 228);
    border-radius: 5px;
    margin-bottom: 5px;

    .recipe_body {
      padding: 12px;
      display: flex;
    }

    .recipe_ingredients {
      display: flex;
      align-items: center;
      flex-direction: column;
    }

    .recipe_ingredient {
      display: flex;
      padding: 5px;
    }

    .recipe_arrow {
      display: flex;
    }

    .recipe_arrow_icon {
      width: 40px;
    }

    .recipe_result {
      padding: 5px;
      display: flex;
      align-items: center;
    }

    .recipe_footer {
      padding: 5px 12px;
      border-top: 1px solid #d2d2d2;
      display: flex;
      flex-direction: row;
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
</style>