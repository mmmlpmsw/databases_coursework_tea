<template>
  <div class="login_dialog_wrapper" :class="{ enabled }">
    <transition-expand>
      <div class="login_dialog" v-if="enabled">
        <loading-screen-container :loading="loading">

          <form class="login_prompt vertical" v-if="mode === 'login'">
            <div class="title">Вход</div>

            <transition-expand>
              <message-panel red v-if="commonErrorHint">
                {{commonErrorHint}}
              </message-panel>
            </transition-expand>

            <transition-expand>
              <message-panel green v-if="commonInfoHint">
                {{commonInfoHint}}
              </message-panel>
            </transition-expand>

            <text-input class="input"
                        v-for="field in login.form"
                        :key="field.id"
                        :hint="field.hint"
                        :type="field.type"
                        v-model="field.value"
                        :error-hint="field.errorHint"/>
            <game-button class="button" type="submit" green @click="loginClicked">Играть!</game-button>
            <a class="link" @click="mode = 'registration'">Регистрация</a>
          </form>

          <form class="registration_prompt vertical" v-if="mode === 'registration'">
            <div class="title">Регистрация</div>

            <transition-expand>
              <message-panel red v-if="commonErrorHint">
                {{commonErrorHint}}
              </message-panel>
            </transition-expand>

            <text-input class="input"
                        v-for="field in registration.form"
                        :key="field.id"
                        :type="field.type"
                        :hint="field.hint"
                        v-model="field.value"
                        :error-hint="field.errorHint"/>
            <game-button class="button" type="submit" green @click="registerClicked">Зарегистрироваться!</game-button>
            <a class="link" @click="mode = 'login'">У меня уже есть аккаунт</a>
          </form>

        </loading-screen-container>
      </div>
    </transition-expand>
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
  import Bootstrap from "$src/game/model/Bootstrap";
  import BootstrapDtoMapper from "$src/api/mapping/BootstrapDtoMapper";
  import MessagePanel from "$src/components/MessagePanel";
  import LoadingScreenContainer from "$src/components/LoadingScreenContainer";
  import RegisterRequestDto from "$src/api/dto/request/RegisterRequestDto";

  export default {
    props: {
      eventBus: Vue
    },
    watch: {
      mode() {
        this.commonErrorHint = null
      }
    },
    data() {
      return {
        enabled: true,
        mode: 'login',
        loading: false,
        commonErrorHint: null,
        commonInfoHint: null,
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
              errorHint: null,
              validation: {
                notEmpty: "Введите имя"
              }
            },
            login: {
              hint: 'Логин',
              value: '',
              errorHint: null,
              validation: {
                notEmpty: "Введите логин"
              }
            },
            password: {
              hint: 'Пароль',
              value: '',
              type: 'password',
              errorHint: null,
              validation: {
                notEmpty: "Введите пароль",
                checkEquals: {
                  fieldName: "confirmPassword",
                  message: "Пароли не совпадают"
                }
              }
            },
            confirmPassword: {
              hint: 'Повторите пароль',
              value: '',
              type: 'password',
              errorHint: null,
              validation: {
                notEmpty: "Введите повтор пароля"
              }
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
          this.loading = true;
          this.commonErrorHint = null;
          this.$api.post(
            "/login",
            new LoginRequestDto(this.login.form.login.value, this.login.form.password.value),
            this.onLoginSuccess,
            () => {
              this.loading = false;
              this.commonErrorHint = "Не удалось войти D:"
            }
          )
        }
      },
      registerClicked() {
        if (this.validateRegister()) {
          this.loading = true;
          this.commonErrorHint = null;
          this.$api.post(
            "/register",
            new RegisterRequestDto(this.registration.form.login.value, this.registration.form.name.value, this.registration.form.password.value),
            this.onRegisterSuccess,
            () => this.commonErrorHint = "Не удалось зарегистрироваться D:",
            () => this.loading = false
          );
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
        let valid = true;
        for (const [key, field] of Object.entries(this.registration.form)) {
          field.errorHint = null;
          if (field.validation.notEmpty && field.value === '') {
            field.errorHint = field.validation.notEmpty;
            valid = false
          } else if (
            field.validation.checkEquals &&
            field.value !== this.registration.form[field.validation.checkEquals.fieldName].value
          ) {
            field.errorHint = field.validation.checkEquals.message;
            valid = false
          }
        }
        return valid;
      },
      onLoginSuccess(tokenHolder) {
        this.$api.token = tokenHolder.token;
        this.loading = true;
        this.$api.get(
          "/bootstrap",
          this.onBootstrapSuccess,
          () => this.commonErrorHint = "Не удалось соединиться с сервером",
          () => this.loading = false
        )
      },
      onBootstrapSuccess(bootstrap) {
        this.$store.commit('doBootstrap', BootstrapDtoMapper.fromDto(bootstrap));
        this.eventBus.$emit(EventBusConstants.LOGGED_IN);
        this.close();
      },
      onRegisterSuccess() {
        this.mode = 'login';
        this.commonInfoHint = "Теперь вы можете войти"
      },
      close() {
        this.enabled = false;
        this.eventBus.$emit(EventBusConstants.DIALOG_CLOSED)
      }
    },
    components: {
      LoadingScreenContainer,
      MessagePanel,
      TransitionExpand,
      'game-button': Button,
      TextInput
    }
  }
</script>

<style lang="scss" scoped>
  .login_dialog_wrapper {
    pointer-events: all;
    position: fixed;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;

    &:not(.enabled) {
      pointer-events: none;
    }
  }

  .login_dialog {
    border-radius: 10px;
    box-shadow: 0 0 50px rgba(0, 0, 0, 0.25);
    background: white;
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

  .button {
    margin-top: 10px;
  }
</style>