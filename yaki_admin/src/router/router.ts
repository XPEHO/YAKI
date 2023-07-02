import {createRouter, createWebHistory} from "vue-router";
import PageLogin from "@/features/login/pages/PageLogin.vue";
import LayoutCaptain from "@/features/captain/layouts/LayoutCaptain.vue";
import LayoutInvitation from "@/features/invitation/layouts/LayoutInvitation.vue";

import PageApplication from "@/features/PageApplication.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  // temporaty routing
  routes: [
    {
      path: "/",
      name: "Login",
      component: PageLogin,
      meta: {transition: "slide-left"},
    },
    {
      path: "/administration",
      name: "Administration",
      component: PageApplication,
      meta: {transition: "slide-right"},
      children: [
        {
          path: "captain",
          component: LayoutCaptain,
        },
        {
          path: "invitation",
          component: LayoutInvitation,
        },
      ],
    },
    // {
    //   path: "/invitation",
    //   name: "Invitation",
    //   component: () => import("@/features/invitation/pages/PageInvitation.vue"),
    // },
  ],
});

export default router;
