import { createRouter, createWebHistory } from "vue-router";
import { useAuthStore } from "@/stores/authStore";

import LoginView from "@/ui/views/LoginView.vue";
import UserInvitationPageContent from "@/features/invitation/layouts/UserInvitationPageContent.vue";
import PageGeneralLayout from "@/ui/layouts/PageGeneralLayout.vue";
import TeamManagementView from "@/ui/views/TeamManagementView.vue";
import TeamStatusNotification from "@/ui/views/TeamStatusNotification.vue";
import CaptainsManagementView from "@/ui/views/CaptainsManagementView.vue";
import ProfileView from "@/ui/views/ProfileView.vue";
import StatisticsView from "@/ui/views/StatisticsView.vue";
import TeamListView from "@/ui/views/TeamListView.vue";
import TeamDetailsView from "@/ui/views/TeamDetailsView.vue";

import { useTeamStore } from "@/stores/teamStore";
import { useRoleStore } from "@/stores/roleStore";
import { TEAMPARAMS } from "@/constants/pathParam.enum";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "Login",
      component: LoginView,
      meta: { transition: "slide-left" },
    },
    {
      path: "/dashboard",
      name: "dashboard",
      component: PageGeneralLayout,
      meta: { transition: "slide-right" },
      children: [
        {
          path: "manage-team",
          component: TeamManagementView,
          beforeEnter: async (to, from, next) => {
            const teamStore = useTeamStore();
            const roleStore = useRoleStore();

            if (teamStore.getIsTeamListSetOnLoggin === false) {
              await teamStore.setTeamsListByCaptainId(roleStore.getCaptainsId);
            }
            if (teamStore.getTeamListByCaptain.length === 0) {
              next(`/dashboard/team/${TEAMPARAMS.empty}`);
            } else {
              next();
            }
          },
        },
        {
          path: "team/:state",
          component: TeamStatusNotification,
        },
        {
          path: "team-details/:id",
          component: TeamDetailsView,
        },
        {
          path: "team-list",
          component: TeamListView,
        },
        {
          path: "manage-captains",
          component: CaptainsManagementView,
        },
        {
          path: "invitation/:role",
          component: UserInvitationPageContent,
        },
        {
          path: "profile",
          component: ProfileView,
        },
        {
          path: "statistics",
          component: StatisticsView,
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

  // Logout on reload
  const role = useRoleStore();
  if (auth.user && role.captainsId.length === 0 && role.customersIdWhereIgotRights.length === 0) {
    auth.logout();
  }

  if (authRequired && !auth.user) {
    auth.returnedUrl = to.fullPath;
    return "/";
  }
});

export default router;
