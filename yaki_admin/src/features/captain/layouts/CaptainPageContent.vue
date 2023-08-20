<script setup lang="ts">
import {onBeforeMount} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";
import router from "@/router/router";

import TeamMate from "../components/teamMate.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import ModalValidation from "@/features/shared/popup/ModalValidation.vue";
import modalValidationState from "@/features/shared/services/modalValidationState";

import plusIcon from "@/assets/plus.png";

const teamStore = useTeamStore();

const fetchTeammates = async () => {
  await teamStore.getTeammateWithinTeam(teamStore.getTeamId);
};

onBeforeMount(async () => {
  fetchTeammates();
});

const removeUserFromTeam = (id: number, informations: string) => {
  teamStore.setTeammateToDelete(id);
  modalValidationState.setInformation(informations);
  modalValidationState.changeVisibility();
};

const validationModalAccept = () => {
  teamStore.deleteTeammateFromTeam(teamStore.getTeammateToDelete);
  setTimeout(() => {
    fetchTeammates();
  }, 150);
};
</script>

<template>
  <modal-validation
    v-show="modalValidationState.isShowed"
    @modal-accept="validationModalAccept" />

  <div class="captain-view">
    <header-content-page
      v-bind:title="'Team Members'"
      v-bind:text="'Manage your team members here'" />
    <side-bar-button
      v-bind:inner-text="'Add Teammate'"
      v-bind:icon-path="plusIcon"
      @click.prevent="router.push({path: `invitation`})" />

    <section class="team-mate-list">
      <team-mate
        :team-mate="teamMate"
        v-for="teamMate in teamStore.getTeammateList"
        :key="teamMate.id"
        @RemoteTeammate="removeUserFromTeam" />
    </section>
  </div>
</template>

<style lang="scss">
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap");

.captain-view {
  padding: 30px;
  font-family: "Inter", sans-serif;
}

.team-mate-list {
  padding: 50px;
  display: flex;
  flex-direction: column;
  align-items: center;

  gap: 3rem;
}
</style>
