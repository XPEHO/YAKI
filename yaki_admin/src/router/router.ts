import {createRouter, createWebHistory} from "vue-router";
import PageCaptain from "@/features/captain/pages/PageCaptain.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "captain",
      component: PageCaptain,
    },
    // {
    //   path: "/other",
    //   name: "other",
    //   component: () => import("..""),
    // },
  ],
});

export default router;
