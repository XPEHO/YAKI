import {createRouter, createWebHistory} from "vue-router";
import PageCaptain from "@/features/captain/pages/PageCaptain.vue";
import PageLogin from "@/features/login/pages/PageLogin.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  // temporaty routing
  routes: [
    {
      path: "/",
      name: "Login",
      component: PageLogin,
    },
    {
      path: "/",
      name: "captain",
      component: PageCaptain,
    },
  ],
});

export default router;
