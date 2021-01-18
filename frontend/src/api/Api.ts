import axios from "axios";

export default class Api {
  public token: string = null;
  public base: string = "/api";

  public get(url: string, result: (any) => void, onerror: (ErrorDto) => void, anyway: () => void = () => {}) {
    axios.get(this.base + url, this.getConfig())
      .then(response => result(response.data))
      .catch(error => onerror(error.response.data))
      .finally(anyway);
  }

  public post(url: string, data: any, result: (any) => void, onerror: (ErrorDto) => void, anyway: () => void = () => {}) {
    axios.post(this.base + url, data, this.getConfig())
      .then(response => result(response.data))
      .catch(error => onerror(error.response.data))
      .finally(anyway);
  }

  private getConfig() {
    let config = {};
    if (this.token !== null)
      config['headers'] = {'x-auth-token': this.token};
    return config;
  }
}

export const ApiPlugin = {
  install(Vue) {
    Vue.prototype.$api = new Api();
  }
};