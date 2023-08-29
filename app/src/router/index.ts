// Composables
import { createRouter, createWebHistory } from 'vue-router'

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
        children: [
          {
            path: '/dashboard',
            name: 'Dashboard',
            component: () => import(/* webpackChunkName: "dashboard" */ '@/views/Dashboard.vue'),
            meta: {
              menuIcon: 'mdi-view-dashboard',
              menuLabel: 'Dashboard',
            }
          },
          {
            path: '/tasks',
            name: 'Tasks',
            component: () => import(/* webpackChunkName: "tasks" */ '@/views/Tasks.vue'),
            meta: {
              menuIcon: 'mdi-notebook',
              menuLabel: 'Tarefas',
            }
          },
          {
            path: '/user-tasks',
            name: 'UserTask',
            component: () => import(/* webpackChunkName: "tasks" */ '@/views/UserTask.vue'),
            meta: {
              menuIcon: 'mdi-file-question',
              menuLabel: 'Tarefa',
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

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
