<script setup lang="ts">
import {onBeforeMount} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";
import router from "@/router/router";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import UserCard from "@/features/shared/components/UserCard.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import PageContentHeader from "@/features/captain/layouts/PageContentheader.vue";

import plusIcon from "@/assets/images/plus.png";
import {useTeammateStore} from "@/stores/teammateStore";

const teamStore = useTeamStore();
const teammateStore = useTeammateStore();

onBeforeMount(async () => {
  await teammateStore.setListOfTeammatesWithinTeam(teamStore.getSelectedTeamId);
});
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header />
    </template>
    <template #content>
      <user-card
        v-for="teammate in teammateStore.getTeammateList"
        :user="teammate"
        :key="teammate.id" />
    </template>
  </page-content-layout>
</template>
@/features/shared/services/modalFrameState
