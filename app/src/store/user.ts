import api from "@/plugins/api";
import { defineStore } from "pinia";

export const enum userTypes {
  System = 1,
  Admin = 2,
  Manager = 3,
  User = 4,
  CustomerAdmin = 5,
  CustomerManager = 6,
  CustomerUser = 7,
}

export const useUserStore = defineStore("user", {
  state: () => ({
    userTypes: [
      { id: userTypes.Admin, label: "Administrador" },
      { id: userTypes.Manager, label: "Gerente" },
      { id: userTypes.User, label: "Funcionário" },
    ],
    customerUserTypes: [
      { id: userTypes.CustomerAdmin, label: "Administrador" },
      { id: userTypes.CustomerManager, label: "Gerente" },
      { id: userTypes.CustomerUser, label: "Funcionário" },
    ],
    allUsers: [],
  }),
  actions: {
    list(payload: any) {
      let query: any = {};

      if (payload) {
        query = {
          search: payload.search ? payload.search : "",
          customerId: payload.customerId,
        };

        if (query.search === "") {
          delete query.search;
        }
      }

      return new Promise((resolve, reject) => {
        api
          .get("/users?" + new URLSearchParams(query).toString())
          .then((response) => {
            this.allUsers = response.data.entities;
            resolve(response.data);
          })
          .catch(reject);
      });
    },
    read(payload: { userId: number; apiParams: any; periodStart?: string, periodEnd?:string, taskId?: number, status?: number }) {
      let params: any = {
        page: payload.apiParams.page,
        limit: payload.apiParams.limit,
      };

      if (payload?.periodStart !== undefined) {
        params.periodStart = payload.periodStart;
      }

      if (payload?.periodEnd !== undefined) {
        params.periodEnd = payload.periodEnd;
      }

      if (payload?.taskId !== undefined) {
        params.taskId = payload.taskId;
      }

      if (payload?.status !== undefined) {
        params.status = payload.status;
      }

      return new Promise((resolve, reject) => {
        api
          .get(
            "/users/" +
              payload.userId +
              "?" +
              new URLSearchParams(params).toString()
          )
          .then((response) => resolve(response.data))
          .catch(reject);
      });
    },
    setRest(payload:any) {
      return new Promise((resolve, reject) => {
        api.put('/users/' + payload.userId + '/set-rest', payload)
          .then((response) => resolve(response.data))
          .catch((reject));
      })
    },
    create(payload: object) {
      return new Promise((resolve, reject) => {
        api
          .post("/users", payload)
          .then((response) => resolve(response.data))
          .catch(reject);
      });
    },
    update(payload: any) {
      return new Promise((resolve, reject) => {
        api
          .put("/users/" + payload.id, payload)
          .then((response) => resolve(response.data))
          .catch(reject);
      });
    },
    delete(id: any) {
      return new Promise((resolve, reject) => {
        api
          .delete("/users/" + id)
          .then((response) => resolve(response.data))
          .catch(reject);
      });
    },
  },
});
