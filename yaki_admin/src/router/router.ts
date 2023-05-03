import {createRouter, createWebHistory} from "vue-router";
import PageCaptain from "@/features/captain/pages/PageCaptain.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  // temporaty routing
  routes: [
    {
      path: "/",
      name: "home",
      component: PageCaptain,
    },
  ],
});

export default router;