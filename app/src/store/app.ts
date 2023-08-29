import api from "@/plugins/api";
import { defineStore } from "pinia";

export const useAppStore = defineStore('app', {
  state: () => ({
    appUser: '',
    apiToken: '',
    snackbar: {
      isVisible: false,
      message: 'null',
    },
  }),
  actions: {
    signIn(payload: object) {
      return new Promise((resolve, reject) => {
        api.post('auth', payload)
          .then(response => {
            let apiToken = response.data.token;
            let appUser = response.data.data;

            api.defaults.headers["Authorization"] = "Bearer " + apiToken;

            this.$patch({
              appUser,
              apiToken
            });

            resolve(response.data);
          })
          .catch(reject);
      })
    },
    passwordReset(payload: object) {
      return new Promise((resolve, reject) => {
        api.post('password-reset', payload)
          .then(response => resolve(response.data))
          .catch(reject);
      })
    },
    setCredentials() {
      let appUser = JSON.parse(localStorage.getItem('appUser')!);
      let apiToken = localStorage.getItem('apiToken')!;

      this.$patch({
        appUser,
        apiToken
      });

      api.defaults.headers["Authorization"] = "Bearer " + apiToken;
    },
    signOut() {
      delete api.defaults.headers["Authorization"];

      this.$patch({
        appUser: '',
        apiToken: ''
      });
    },
    setSnackbar(message: string) {
      this.$patch({
        snackbar: {
          isVisible: true,
          message
        }
      })
    },
  }
})