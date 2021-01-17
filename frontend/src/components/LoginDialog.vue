<template>
  <div class="login_dialog" v-if="enabled">

    <form class="login_prompt vertical" v-if="mode === 'login'">
      <div class="title">Вход</div>
      <text-input class="input"
                  v-for="field in login.form"
                  :key="field.id"
                  :hint="field.hint"
                  :type="field.type"
                  v-model="field.value"
                  :error-hint="field.errorHint"/>
      <game-button type="submit" green @click="loginClicked">Играть!</game-button>
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
      <game-button type="submit" green @click="registerClicked">Зарегистрироваться!</game-button>
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
  import LoginRequestDto from "$src/api/dto/request/LoginRequestDto";
  import TokenDto from "$src/api/dto/TokenDto";
  import Api from "$src/api/Api";

  export default {
    props: {
      eventBus: Vue
    },
    data() {
      return {
        enabled: true,
        mode: 'login',
        login: {
          form: {
            login: {
              hint: "Логин",
              value: '',
              errorHint: null,
              validation: {
                notEmpty: "Введите логин"
              }
            },
            password: {
              hint: "Пароль",
              value: '',
              type: 'password',
              errorHint: null,
              validation: {
                notEmpty: "Введите пароль"
              }
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
      loginClicked() {
        if (this.validateLogin()) {
          this.$api.call(
            "/login",
            new LoginRequestDto(
              this.login.form.login.value,
              this.login.form.password.value,
            ),
            (result) => {alert('token:' + result.token)},
            (error) => {alert("отвал жопы")}
          )
        }
      },
      registerClicked() {
        if (this.validateRegister()) {
          // todo
        }
      },
      validateLogin() {
        let valid = true;
        for (const [key, field] of Object.entries(this.login.form)) {
          field.errorHint = null;
          if (field.validation.notEmpty && field.value === '') {
            field.errorHint = field.validation.notEmpty;
            valid = false
          }
        }
        return valid;
      },
      validateRegister() {

      },
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
    font-size: 32px;
    margin-bottom: 10px;
  }

  .link {
    text-align: center;
    margin-top: 10px;
    cursor: pointer;
  }
</style>