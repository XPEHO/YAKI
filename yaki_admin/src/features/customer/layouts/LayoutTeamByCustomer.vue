<script setup lang="ts">
import {onBeforeMount} from "vue";

import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import { useTeamStore } from "@/stores/teamStore";
import { useRoleStore } from "@/stores/roleStore";


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
  <header-content-page
    v-bind:title="'Teams List'"
    v-bind:text="'Manage your teams here'" />

  <div class="team-list">
    <div
      class="team-item"
      :team="team"
      v-for="team in teamStore.getTeamList"
      :key="team.id">
      {{ team.teamName }}
    </div>
  </div>
</template>

<style lang="scss">
.customer-view,
.team-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  align-items: center;
  max-width: 70vw;
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
