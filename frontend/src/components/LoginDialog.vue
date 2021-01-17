<template>
  <div class="login_dialog">

    <form class="login_prompt vertical" v-if="mode === 'login'">
      <div class="title">Вход</div>
      <text-input class="input"
                  v-for="field in login.form"
                  :key="field.id"
                  :hint="field.hint"
                  :type="field.type"
                  v-model="field.value"
                  :error-hint="field.errorHint"/>
      <game-button green>Играть!</game-button>
      <a class="link" @click="mode = 'registration'">Регистрация</a>
    </form>

    <form class="registration_prompt vertical" v-if="mode === 'registration'">
      <div class="title">Регистрация</div>
      <text-input class="input"
                  v-for="field in registration.form"
                  :key="field.id"
                  :type="field.type"
                  :hint="field.hint"
                  v-model="field.value"
                  :error-hint="field.errorHint"/>
      <game-button green>Зарегистрироваться!</game-button>
      <a class="link" @click="mode = 'login'">У меня уже есть аккаунт</a>
    </form>
  </div>
</template>

<script>
  import EventBusConstants from "$src/util/EventBusConstants";
  import Vue from 'vue';
  import TextInput from "$src/components/TextInput";
  import Button from "$src/components/Button";
  import TransitionExpand from "$src/components/TransitionExpand";

  export default {
    props: {
      eventBus: Vue
    },
    data() {
      return {
        mode: 'login',
        login: {
          form: {
            login: {
              hint: "Логин",
              value: '',
              errorHint: null
            },
            password: {
              hint: "Пароль",
              value: '',
              type: 'password',
              errorHint: null
            }
          }
        },
        registration: {
          form: {
            name: {
              hint: 'Имя',
              value: '',
              errorHint: null
            },
            login: {
              hint: 'Логин',
              value: '',
              errorHint: null
            },
            password: {
              hint: 'Пароль',
              value: '',
              type: 'password',
              errorHint: null
            },
            confirmPassword: {
              hint: 'Повторите пароль',
              value: '',
              type: 'password',
              errorHint: null
            }
          }
        }
      }
    },
    mounted() {
      this.eventBus.$emit(EventBusConstants.DIALOG_OPENED)
    },
    methods: {
      close() {
        this.eventBus.$emit(EventBusConstants.DIALOG_CLOSED)
      }
    },
    components: {
      TransitionExpand,
      'game-button': Button,
      TextInput
    }
  }
</script>

<style scoped>
  .login_dialog {
    border-radius: 10px;
    box-shadow: 0 0 50px rgba(0, 0, 0, 0.25);
    transform: translate(-50%, -50%);
    left: 50%;
    top: 50%;
    background: white;
    position: fixed;
    padding: 30px;
  }

  .vertical {
    display: flex;
    flex-direction: column;
  }

  .title {
    text-align: center;
    font-size: 24px;
    margin-bottom: 10px;
  }

  .link {
    text-align: center;
    margin-top: 10px;
    cursor: pointer;
  }
</style>