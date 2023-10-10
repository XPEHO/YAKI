import {createRouter, createWebHistory} from "vue-router";
import {useAuthStore} from "@/stores/authStore";
import PageLogin from "@/features/login/pages/PageLogin.vue";
import RegistrationConfirmationPage from "@/features/registrationConfirmation/RegistrationConfirmationPage.vue";
import UserInvitationPageContent from "@/features/invitation/layouts/UserInvitationPageContent.vue";

import CaptainPage from "@/features/captain/CaptainPage.vue";
import CaptainPageContent from "@/features/captain/layouts/CaptainPageContent.vue";

import CustomerPage from "@/features/customer/CustomerPage.vue";
import CustomerPageContentTeamList from "@/features/customer/layouts/CustomerPageContentTeamList.vue";
import CustomerPageContentCaptainList from "@/features/customer/layouts/CustomerPageContentCaptainList.vue";

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
      path: "/registerConfirm",
      name: "registerConfirm",
      component: RegistrationConfirmationPage,
      props: (route) => ({ token: route.query.token }),
      
    },
    {
      path: "/captain",
      name: "Captain",
      component: CaptainPage,
      meta: {transition: "slide-right"},
      children: [
        {
          path: "manage-team",
          component: CaptainPageContent,
        },
        {
          path: "invitation",
          component: UserInvitationPageContent,
        },
      ],
    },
    {
      path: "/customer",
      name: "Customer",
      component: CustomerPage,
      meta: {transition: "slide-left"},
      children: [
        {
          path: "manage-captain",
          component: CustomerPageContentCaptainList,
        },
        {
          path: "manage-team",
          component: CustomerPageContentTeamList,
        },
        {
          path: "invitation",
          component: UserInvitationPageContent,
        },
        {
          path: "admin-invitation",
          component: UserInvitationPageContent,
        }
      ],
    },
  ],
});

// BEGIN: be15d9bcejpp
router.beforeEach(async (to) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ["/", "/registerConfirm"];
  const authRequired = !publicPages.includes(to.path);
  const auth = useAuthStore();

  if (authRequired && !auth.user) {
    auth.returnedUrl = to.fullPath;
    return "/";
  }
});

export default router;
