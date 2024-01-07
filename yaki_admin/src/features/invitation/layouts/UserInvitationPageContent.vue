<script setup lang="ts">
import { environmentVar } from "@/envPlaceholder";
import { onBeforeMount, reactive } from "vue";

import type { UserWithIdType } from "@/models/userWithId.type";
import { usersService } from "@/services/users.service";

import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import InvitationViewHeader from "@/features/invitation/components/InvitationViewHeader.vue";
import UserInvitationList from "@/features/invitation/components/UserInvitationList.vue";

import { useRoute } from "vue-router";
import { useTeamStore } from "@/stores/teamStore";
import { INVITEDROLE } from "@/constants/pathParam.enum";
import { useSelectedRoleStore } from "@/stores/selectedRole";
import { useTeammateStore } from "@/stores/teammateStore";
import { useCaptainStore } from "@/stores/captainStore";

const route = useRoute();
const invitationRole = route.params.role as INVITEDROLE;

const teamStore = useTeamStore();
const selectedRoleStore = useSelectedRoleStore();
const teammateStore = useTeammateStore();
const captainStore = useCaptainStore();

const props = reactive({
  userList: [] as UserWithIdType[],
  fromRoute: "" as string,
  alreadInvitedUsers: [] as number[],
});
//list of person who have admin rights in company
//don't want to fetch them in each separated component

const getListOfUserAlreadyAccepted = async (invitedRole: string) => {
  if (invitedRole == INVITEDROLE.teammate) {
    return teammateStore.getTeammateList.map((teammate) => teammate.id);
  }
  if (invitedRole == INVITEDROLE.captain) {
    return captainStore.getCaptainList.map((captain) => captain.id);
  }
  return [];
};

onBeforeMount(async () => {
  props.alreadInvitedUsers = await getListOfUserAlreadyAccepted(invitationRole);
  props.userList = await usersService.fetchUserInRange(
    environmentVar.tempUserIdRangeStart,
    environmentVar.tempUserIdRAngeEnd,
  );
});

const onUserInvitation = (invitedUser: UserWithIdType) => {
  if (invitationRole === INVITEDROLE.teammate) {
    teamStore.addUserToTeam(invitedUser.id);
  }
  if (invitationRole === INVITEDROLE.captain) {
    selectedRoleStore.addCaptainToCompany(invitedUser.id);
  }
};
</script>
<template>
  <page-content-layout>
    <template #pageContentHeader>
      <invitation-view-header v-bind:invited-role="invitationRole" />
    </template>

    <template #content>
      <user-invitation-list
        v-if="props.userList && props.userList.length > 0"
        :userList="props.userList"
        :invitedUsers="props.alreadInvitedUsers"
        :testprops="'test de props'"
        @emittedUserInvitation="onUserInvitation"
      />
    </template>
  </page-content-layout>
</template>
