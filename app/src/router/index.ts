// Composables
import { useAppStore } from '@/store/app';
import { userTypes } from '@/store/user'
import { RouteLocationNormalized, Router, createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    children: [
      {
        path: "/login",
        name: "Login",
        component: () => import(/* webpackChunkName: "login" */ "@/views/Login.vue"),
      },
      {
        path: '/',
        name: 'Home',
        component: () => import(/* webpackChunkName: "home" */ '@/views/Home.vue'),
        meta: {
          permission: [
            userTypes.Admin,
            userTypes.Teacher,
            userTypes.Student,
          ],
        },
        children: [
          {
            path: '/dashboard',
            name: 'Dashboard',
            component: () => import(/* webpackChunkName: "dashboard" */ '@/views/Dashboard.vue'),
            meta: {
              menuIcon: 'mdi-view-dashboard',
              menuLabel: 'Dashboard',
              permission: [
                userTypes.Admin,
                userTypes.Teacher,
                userTypes.Student,
              ],
            }
          },
          {
            path: '/tasks',
            name: 'Tasks',
            component: () => import(/* webpackChunkName: "tasks" */ '@/views/Tasks.vue'),
            meta: {
              menuIcon: 'mdi-notebook',
              menuLabel: 'Tarefas',
              permission: [
                userTypes.Teacher,
                userTypes.Student,
              ],
            }
          },
          {
            path: '/user-tasks',
            name: 'UserTask',
            component: () => import(/* webpackChunkName: "tasks" */ '@/views/UserTask.vue'),
            meta: {
              menuIcon: 'mdi-file-question',
              menuLabel: 'Tarefa',
              permission: [
                userTypes.Student,
              ],
            }
          },
          {
            path: '/question',
            name: 'Question',
            component: () => import(/* webpackChunkName: "question" */ '@/views/QuestionRegister.vue'),
            meta: {
              menuIcon: 'mdi-pencil',
              menuLabel: 'Questões',
            }
          },
        ]
      },
    ],
  },
]

const router: Router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

let appStore: any;

router.beforeEach((to: RouteLocationNormalized, from, next) => {
  if (!appStore) {
    appStore = useAppStore();
  }

  if (!to.meta.hasOwnProperty("permission")) {
    next();
  } else {
    if (appStore.apiToken === "" && localStorage.getItem("apiToken")) {
      appStore.setCredentials();
    }

    if (appStore.apiToken !== "") {
      if (hasUserAuthorization(to)) {
        next();
      } else {
        router.push("/dashboard");
      }
    } else {
      router.push("/login");
    }
  }
});

function hasUserAuthorization(to: RouteLocationNormalized): boolean {
  return (to.meta.permission as Array<number>).includes(
    (appStore.appUser as any).type
  );
}

export default router
