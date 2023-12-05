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
                userTypes.SystemAdmin,
                userTypes.Admin,
                userTypes.Teacher,
                userTypes.Student,
              ],
            }
          },
          {
            path: '/institutions',
            name: 'Institutions',
            component: () => import(/* webpackChunkName: "tasks" */ '@/views/Tasks.vue'),
            meta: {
              menuIcon: 'mdi-domain',
              menuLabel: 'Instituições',
              permission: [
                userTypes.SystemAdmin,
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
            path: '/student-tasks',
            name: 'StudentTask',
            component: () => import(/* webpackChunkName: "studentTask" */ '@/views/StudentTask.vue'),
            meta: {
              permission: [
                userTypes.Student,
              ],
            }
          },
          {
            path: '/student-ranking',
            name: 'StudentRanking',
            component: () => import(/* webpackChunkName: "studentTask" */ '@/views/StudentRanking.vue'),
            meta: {
              menuIcon: 'mdi-chart-areaspline',
              menuLabel: 'Desempenho',
              permission: [
                userTypes.Student,
              ],
            }
          },
          {
            path: '/question-tasks/:id',
            name: 'UserTaskPlay',
            component: () => import(/* webpackChunkName: "question" */ '@/views/UserTask.vue'),
            meta: {
              permission: [
                userTypes.Student,
              ],
            }
          },
          {
            path: '/tasks/new',
            name: 'UserTask',
            component: () => import(/* webpackChunkName: "question" */ '@/views/TaskRegister.vue'),
            meta: {
              permission: [
                userTypes.Teacher,
              ],
            }
          },
          {
            path: '/teacher-ranking',
            name: 'TeacherRanking',
            component: () => import(/* webpackChunkName: "question" */ '@/views/TeacherRanking.vue'),
            meta: {
              menuIcon: 'mdi-chart-areaspline',
              menuLabel: 'Desempenhos',
              permission: [
                userTypes.Teacher,
              ],
            }
          },
          {
            path: '/tasks/:id',
            name: 'UserTaskEdit',
            component: () => import(/* webpackChunkName: "question" */ '@/views/TaskRegister.vue'),
            meta: {
              permission: [
                userTypes.Teacher,
              ],
            }
          },
          {
            path: '/tasks/:id/analyse',
            name: 'UserTaskAnalyse',
            component: () => import(/* webpackChunkName: "question" */ '@/views/AnalyseTask.vue'),
            meta: {
              permission: [
                userTypes.Teacher,
              ],
            }
          },
          {
            path: '/subjects/:id',
            name: 'Subject',
            component: () => import(/* webpackChunkName: "question" */ '@/views/Students.vue'),
            meta: {
              menuIcon: 'mdi-account-group',
              menuLabel: 'Estudantes',
              permission: [
                userTypes.Teacher,
              ],
            }
          }
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
