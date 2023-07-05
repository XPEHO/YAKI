import {createRouter, createWebHistory} from "vue-router";
import { useAuthStore } from '@/stores/authStore';
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
  ],
});

router.beforeEach(async (to) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/login'];
  const authRequired = !publicPages.includes(to.path);
  const auth = useAuthStore();

  if (authRequired && !auth.user) {
      auth.returnedUrl = to.fullPath;
      return '/login';
  }
});

export default router;
