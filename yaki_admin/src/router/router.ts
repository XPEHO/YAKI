import { createRouter, createWebHistory } from "vue-router";
import { useAuthStore } from "@/stores/authStore";
import PageLogin from "@/features/login/pages/PageLogin.vue";
import LayoutCaptain from "@/features/captain/layouts/LayoutCaptain.vue";
import LayoutInvitation from "@/features/invitation/layouts/LayoutInvitation.vue";
import LayoutCustomer from "@/features/customer/layouts/LayoutCustomer.vue";
import LayoutCaptainByCustomer from "@/features/customer/layouts/LayoutCaptainByCustomer.vue";

import PageApplication from "@/features/PageApplication.vue";
import LayoutTeamByCustomer from "@/features/customer/layouts/LayoutTeamByCustomer.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  // temporaty routing
  routes: [
    {
      path: "/",
      name: "Login",
      component: PageLogin,
      meta: { transition: "slide-left" },
    },
    {
      path: "/administration",
      name: "Administration",
      component: PageApplication,
      meta: { transition: "slide-right" },
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
    {
      path: "/customer",
      name: "Customer",
      component: LayoutCustomer,
      meta: { transition: "slide-left" },
      children: [
        {
          path: "manage-captain",
          component: LayoutCaptainByCustomer,
        },
        {
          path: "manage-team",
          component: LayoutTeamByCustomer,
        },
        {
          path: "invitation",
          component: LayoutInvitation,
        },
      ],
    },
  ],
});

// BEGIN: be15d9bcejpp
router.beforeEach(async (to) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ["/"];
  const authRequired = !publicPages.includes(to.path);
  const auth = useAuthStore();

  if (authRequired && !auth.user) {
    auth.returnedUrl = to.fullPath;
    return "/";
  }
});

export default router;
