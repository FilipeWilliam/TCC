import api from "@/plugins/api";
import { defineStore } from "pinia";

export const useTaskStore = defineStore('task', {
  state: () => ({
    allTasks: [],
  }),
  actions: {
    list(payload: any) {
      let query: any = {};

      if (payload) {
        query = {
          search: payload.search ? payload.search : '',
        };

        if (query.search === "") {
          delete query.search;
        }
      }

      return new Promise((resolve, reject) => {
        api.get("/tasks?" + new URLSearchParams(query).toString())
          .then((response) => {
            this.allTasks = response.data;
            resolve(response.data);
          })
          .catch(reject);
      });
    },
    read(payload: any) {
      return new Promise((resolve, reject) => {
        api.get("/tasks/" + payload)
          .then((response) => resolve(response.data))
          .catch(reject);
      });
    },
    create(payload: object) {
      return new Promise((resolve, reject) => {
        api.post("/tasks", payload)
          .then((response) => resolve(response.data))
          .catch(reject);
      });
    },
    update(payload: any) {
      return new Promise((resolve, reject) => {
        api.put("/tasks/" + payload.id, payload)
          .then((response) => resolve(response.data))
          .catch(reject);
      });
    },
    delete(id: any) {
      return new Promise((resolve, reject) => {
        api.delete("/tasks/" + id)
          .then((response) => resolve(response.data))
          .catch(reject);
      });
    },
  },
});
