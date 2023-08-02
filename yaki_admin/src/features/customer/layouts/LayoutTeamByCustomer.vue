<script setup lang="ts">
import { onBeforeMount } from "vue";

import { useTeamStore } from "@/stores/teamStore";
import { useCustomerRightsStore } from "@/stores/customerRightsStore";

const teamStore = useTeamStore();
const customerRight = useCustomerRightsStore();

const fetchTeams = async () => {
  await teamStore.getTeamsFromCustomer(customerRight.getCustomersRightsId);
};

onBeforeMount(async () => {
  fetchTeams();
});
</script>

<template>
  <div class="layout-team">
    <div class="customer-view-teams">
      <h1 class="title">Teams List</h1>
      <h2 class="text">Manage your teams</h2>
      <hr class="line" />

      <div class="team-list">
        <div
          class="team-item"
          :team="team"
          v-for="team in teamStore.getTeamList"
          :key="team.id">
          {{ team.teamName }}
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
.customer-view,
.customer-view-teams {
  padding: 2rem;
}
.team-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  padding: 2rem;
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
