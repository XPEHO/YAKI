<script setup lang="ts">
import {onBeforeMount} from "vue";

import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import {useTeamStore} from "@/stores/teamStore";
import {useRoleStore} from "@/stores/roleStore";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import plusIcon from "@/assets/images/plus.png";

const teamStore = useTeamStore();
const roleStore = useRoleStore();

const fetchTeams = async () => {
  await teamStore.setTeamsFromCustomer(roleStore.getCustomersIdWhereIgotRights);
};

onBeforeMount(async () => {
  fetchTeams();
});
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <header-content-page
        v-bind:title="'Teams List'"
        v-bind:text="'Manage your teams here'" />
    </template>
    <template #content>
      <SideBarButton
        v-bind:inner-text="'Add a team'"
        v-bind:icon-path="plusIcon"
        @click.prevent="() => {}" />

      <div class="team-list">
        <div
          v-for="team in teamStore.getTeamList"
          class="team-item"
          :team="team"
          :key="team.id">
          {{ team.teamName }}
        </div>
      </div>
    </template>
  </page-content-layout>
</template>

<style lang="scss">
.team-list {
  padding-block-start: 1.5rem;
}

.team-item {
  border: 1px solid #ccc;
  background-color: rgb(177, 173, 173);
  border-radius: 10px;
  padding: 1rem;
  width: 20vw;
  text-align: center;
}
</style>
