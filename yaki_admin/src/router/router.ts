import {createRouter, createWebHistory} from "vue-router";
import {useAuthStore} from "@/stores/authStore";
import LoginView from "@/features/login/LoginView.vue";
import UserInvitationPageContent from "@/features/invitation/layouts/UserInvitationPageContent.vue";

import PageGeneralLayout from "@/layouts/PageGeneralLayout.vue";
import CaptainView from "@/views/captain/CaptainView.vue";
import CaptainNoTeamView from "@/views/captain/CaptainNoTeamView.vue";
import CustomerCaptainsView from "@/features/customer/CustomerCaptainsView.vue";

import {useTeamStore} from "@/stores/teamStore";
import {useRoleStore} from "@/stores/roleStore";
import {TEAMPARAMS} from "@/constants/pathParam";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "Login",
      component: LoginView,
      meta: {transition: "slide-left"},
    },
    {
      path: "/dashboard",
      name: "dashboard",
      component: PageGeneralLayout,
      meta: {transition: "slide-right"},
      children: [
        {
          path: "manage-team",
          component: CaptainView,
          beforeEnter: async (to, from, next) => {
            const teamStore = useTeamStore();
            const roleStore = useRoleStore();

            if (teamStore.getIsTeamListSetOnLoggin === false) {
              await teamStore.setTeamListOfACaptain(roleStore.getCaptainsId);
            }
            if (teamStore.getTeamList.length === 0) {
              next(`/dashboard/team/${TEAMPARAMS.empty}`);
            } else {
              next();
            }
          },
        },
        {
          path: "team/:state",
          component: NoTeamView,
        },
        {
          path: "invitation",
          component: UserInvitationPageContent,
        },
        {
          path: "captains",
          component: CustomerCaptainsView,
        },
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
