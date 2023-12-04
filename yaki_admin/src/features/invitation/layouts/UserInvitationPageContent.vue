<script setup lang="ts">
import router from "@/router/router";
import {environmentVar} from "@/envPlaceholder";
import {onBeforeMount, reactive} from "vue";

import type {UserWithIdType} from "@/models/userWithId.type";
import {usersService} from "@/services/users.service";

import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import UserInvitationCard from "@/features/invitation/components/InvitationCard.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import backIcon from "@/assets/images/arrow-back.png";

import {
  changeHeaderTitle,
  changeHeaderSubText,
  invitUser,
  getListOfUserAlreadyAccepted,
  getInvitationStatusText,
  getReturnText,
} from "@/features/invitation/services/invitationService";

import {useRoute} from "vue-router";
import {useTeamStore} from "@/stores/teamStore";
const route = useRoute();
const invitationRole = route.params.role as string;
const teamStore = useTeamStore();

const props = reactive({
  userList: [] as UserWithIdType[],
  fromRoute: "" as string,
  alreadyInList: [] as number[],
  invitationStatusText: "" as string,
});
//list of person who have admin rights in company
//don't want to fetch them in each separated component

onBeforeMount(async () => {
  props.alreadyInList = await getListOfUserAlreadyAccepted(invitationRole);
  props.userList = await usersService.fetchUserInRange(
    environmentVar.tempUserIdRangeStart,
    environmentVar.tempUserIdRAngeEnd
  );
  props.invitationStatusText = getInvitationStatusText(invitationRole);
});
// invit button from user-component
</script>
<template>
  <page-content-layout>
    <template #pageContentHeader>
      <header-content-page
        v-bind:title="changeHeaderTitle(invitationRole)"
        v-bind:text="changeHeaderSubText(invitationRole, teamStore.getTeamSelected.teamName)" />
    </template>

    <template #content>
      <side-bar-button
        v-if="invitationRole != '/customer/admin-invitation'"
        v-bind:inner-text="getReturnText(invitationRole)"
        v-bind:icon-path="backIcon"
        @click.prevent="router.go(-1)" />

      <user-invitation-card
        v-for="user in props.userList"
        v-bind:key="user.id"
        v-bind:user="user"
        v-bind:invitation-role="invitationRole"
        v-bind:adminList="props.alreadyInList"
        v-bind:invitationStatusText="props.invitationStatusText"
        @invitUserToTeam="invitUser" />
    </template>
  </page-content-layout>
</template>
