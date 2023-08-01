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
    <div class="customer-view">
      <h1 class="title">Teams List</h1>
      <h2 class="text">Manage your teams</h2>
      <hr class="line" />

      <div class="team-list">
        <team
          :team="team"
          v-for="team in teamStore.getTeamList"
          :key="team.id" />
      </div>
    </div>
  </div>
</template>
