<script setup lang="ts">
import router from "@/router/router";
import {onBeforeMount, reactive} from "vue";
import {useTeamStore} from "@/stores/teamStore";
import {environmentVar} from "@/envPlaceholder";

import type {UserWithIdType} from "@/models/userWithId.type";
import {usersService} from "@/services/users.service";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import UserInvitationCard from "@/features/invitation/components/UserInvitationCard.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import backIcon from "@/assets/images/arrow-back.png";

const teamStore = useTeamStore();

const users = reactive({
  list: [] as UserWithIdType[],
});

onBeforeMount(async () => {
  users.list = await usersService.fetchUserInRange(
    environmentVar.tempUserIdRangeStart,
    environmentVar.tempUserIdRAngeEnd
  );
});

// invit button from user-component
const addUserToTeam = async (userId: number) => {
  teamStore.addUserToTeam(userId);
};
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <header-content-page
        v-bind:title="'Invite Teammate'"
        v-bind:text="'Select the teammate(s) you want to invit to : ' + teamStore.getTeamName" />
    </template>

    <template #content>
      <side-bar-button
        v-bind:inner-text="'Return to teammate list'"
        v-bind:icon-path="backIcon"
        @click.prevent="router.go(-1)" />

      <user-invitation-card
        v-for="user in users.list"
        v-bind:key="user.id"
        class="user_unit"
        v-bind:user="user"
        v-bind:isInTeam="false"
        @GetUserId="addUserToTeam" />
    </template>
  </page-content-layout>
</template>
