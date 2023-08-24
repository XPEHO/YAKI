<script setup lang="ts">
import {onBeforeMount} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";
import router from "@/router/router";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import UserCard from "@/features/shared/components/UserCard.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";

import plusIcon from "@/assets/images/plus.png";
import {useTeammateStore} from "@/stores/teammateStore";

const teamStore = useTeamStore();
const teammateStore = useTeammateStore();

onBeforeMount(async () => {
  await teammateStore.setTeammatesWithinTeam(teamStore.getTeamId);
});
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <header-content-page
        v-bind:title="'Team Members'"
        v-bind:text="'Manage your team members here'" />
    </template>
    <template #content>
      <side-bar-button
        v-bind:inner-text="'Add Teammate'"
        v-bind:icon-path="plusIcon"
        @click.prevent="router.push({path: `invitation`})" />

      <user-card
        v-for="teammate in teammateStore.getTeammateList"
        :user="teammate"
        :key="teammate.id" />
    </template>
  </page-content-layout>
</template>
@/features/shared/services/modalFrameState
