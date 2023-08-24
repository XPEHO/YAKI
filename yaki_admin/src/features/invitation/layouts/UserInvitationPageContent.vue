<script setup lang="ts">
import router from "@/router/router";
import {environmentVar} from "@/envPlaceholder";
import {onBeforeMount, reactive, watch} from "vue";
import {useTeamStore} from "@/stores/teamStore";
import modalState from "@/features/shared/services/modalState";

import type {UserWithIdType} from "@/models/userWithId.type";
import {usersService} from "@/services/users.service";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import UserInvitationCard from "@/features/invitation/components/InvitationCard.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import backIcon from "@/assets/images/arrow-back.png";

import {changeHeaderTitle, changeHeaderSubText} from "@/features/invitation/services/userService";

import {useRoute} from "vue-router";

const teamStore = useTeamStore();
const route = useRoute();

const props = reactive({
  list: [] as UserWithIdType[],
  fromRoute: "" as string,
});

onBeforeMount(async () => {
  props.list = await usersService.fetchUserInRange(
    environmentVar.tempUserIdRangeStart,
    environmentVar.tempUserIdRAngeEnd
  );
  props.fromRoute = route.path;
});

// invit button from user-component
const invitUser = async (userId: number) => {
  teamStore.addUserToTeam(userId);
};
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <header-content-page
        v-bind:title="changeHeaderTitle(props.fromRoute)"
        v-bind:text="changeHeaderSubText(props.fromRoute, modalState.teamName)" />
    </template>

    <template #content>
      <side-bar-button
        v-bind:inner-text="'Return to teammate list'"
        v-bind:icon-path="backIcon"
        @click.prevent="router.go(-1)" />

      <user-invitation-card
        v-for="user in props.list"
        v-bind:key="user.id"
        v-bind:user="user"
        v-bind:fromRoute="props.fromRoute"
        @invitUserToTeam="invitUser" />
    </template>
  </page-content-layout>
</template>
