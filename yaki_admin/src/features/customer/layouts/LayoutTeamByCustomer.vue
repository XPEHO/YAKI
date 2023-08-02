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
        :team="team" 
        v-for="team 
        in teamStore.getTeamList" 
        :key="team.id">
          {{ team.teamName }}
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
.customer-view {
  padding: 2rem;
  width: 70vw;
}
.customer-view-teams {
  padding: 2rem;
}
.team-list {
  padding: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3rem;
}
</style>
