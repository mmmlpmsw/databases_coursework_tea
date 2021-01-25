<template>
  <common-items-dialog  :enabled="enabled" @close-request="closeDialog">
    <template v-slot:header>
      Магазин
    </template>
    <template v-slot:container>
      <div class="items">

        <div  class="item"
              v-for="item in $store.state.game.teas"
              :class="{
                too_expensive: item.price > $store.state.user.money,
                selected: selectedItem === item
              }"
              @click="selectedItem = item">
          <div class="image" :style="{ backgroundImage: `url('assets/image/game/teas/id${item.id}/image.png')` }"></div>
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
          <div class="image" :style="{ backgroundImage: `url('assets/image/game/teas/id${selectedItem.id}/image.png')` }"></div>
          <div class="title">{{ selectedItem.name }}</div>
          <div class="description">{{ selectedItem.description }}</div>
          <div class="in_inventory" v-if="$store.state.game.teaInstances[selectedItem.id]">Имеется {{$store.state.game.teaInstances[selectedItem.id].amount}} шт. в инвентаре</div>
        </div>
        <div class="item_info_bottom">
          <loading-screen-container :loading="loading">
            <label>
              Количество:
              <input type="number" min="1" v-model="selectedAmount">
            </label>
              <game-button green class="item_info_buy_button" v-if="selectedItem.price * selectedAmount <= $store.state.user.money" @click="onBuyButtonClick">
                Приобрести за
                <!--            TODO отдельный компонент-->
                <div class="price">
                  <div class="money_icon_wrapper">
                    <img class="money_icon" src="assets/image/game/money_icon.svg">
                  </div>
                  {{ selectedItem.price * selectedAmount }}
                </div>
              </game-button>
            <div v-else class="item_info_too_expensive">
              Недостаточно тикоинов, чтобы приобрести
            </div>
          </loading-screen-container>
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
  import BuyTeaRequestDto from "$src/api/dto/request/BuyTeaRequestDto";
  import TeaInstance from "$src/game/model/TeaInstance";
  import LoadingScreenContainer from "$src/components/LoadingScreenContainer";

  export default {
    components: {LoadingScreenContainer, BubbleHintTeaIcon, BubbleHintCircuitBoardIcon, CommonItemsDialog, GameButton: Button },
    props: {
      eventBus: Vue
    },
    data() {
      return {
        loading: false,
        enabled: false,
        selectedItem: null,
        selectedAmount: 1
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
      },
      onBuyButtonClick() {
        this.loading = true;
        if (this.selectedAmount < 0) {
          this.selectedAmount = 0;
        }
        this.$api.post(
          '/tea/buy',
          new BuyTeaRequestDto(this.selectedItem.id, this.selectedAmount),
          () => {
            this.$store.commit('buyTeaInstance', new TeaInstance(this.selectedItem.id, +this.selectedAmount))
          },
          (error) => {
            console.error("PANIC!"); // todo
            console.error(error);
          },
          () => this.loading = false
        )
      }
    },
    mounted() {
      this.eventBus.$on(EventBusConstants.REQUEST_TEA_SHOP_DIALOG, this.openDialog);
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

      .in_inventory {
        color: green;
        font-weight: bold;
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