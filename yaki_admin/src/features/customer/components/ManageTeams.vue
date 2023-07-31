<script setup="ts">
import modalValidationState from "@/features/shared/services/modalValidationState";
import ModalValidation from "@/features/shared/components/ModalValidation.vue";

import { onBeforeMount } from "vue";
import { useTeamStore } from "../../../../src/stores/teamStore.ts";

const teamStore = useTeamStore();

const fetchTeams = async () => {
  await teamStore.getAllTeamsByCustomer(teamStore.getCustomerId);
};

onBeforeMount(async () => {
  fetchTeams();
});

const removeTeamFromCustomer = (id, informations) => {
  teamStore.setTeamToDelete(id);
  modalValidationState.setInformation(informations);
  modalValidationState.changeVisibility();
};

const validationModalAccept = () => {
  teamStore.deleteTeam(teamStore.getTeamToDelete);
  setTimeout(() => {
    fetchTeams();
  }, 150);
};
</script>

<template>
  <modal-validation
    v-show="modalValidationState.isShowed"
    @modal-accept="validationModalAccept" />

  <div class="customer-view">
    <h1 class="title">Teams List</h1>
    <h2 class="text">Manage your teams</h2>
    <hr class="line" />

    <div class="team-list">
      <team
        :team="team"
        v-for="team in teamStore.getTeamList"
        :key="team.id"
        @RemoteTeam="removeTeamFromCustomer" />
    </div>
  </div>
</template>

<style lang="scss"></style>
