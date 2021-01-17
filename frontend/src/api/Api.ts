import axios from "axios";

export default class Api {
  public token: string = null;
  public base: string = "/api";

  public call(url: string, data: any, result: (any) => void, onerror: (ErrorDto) => void) {
    let config = {};
    if (this.token !== null)
      config['headers'] = {'x-auth-token': this.token};

    axios.post(this.base + url, data, config)
      .then(response => result(response.data))
      .catch(error => onerror(error.response.data));
  }
}

export const ApiPlugin = {
  install(Vue) {
    Vue.prototype.$api = new Api();
  }
};