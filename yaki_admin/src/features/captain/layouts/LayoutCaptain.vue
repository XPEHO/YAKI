<script setup lang="ts">
// Importing necessary modules and types
import TeamMate from "../components/teamMate.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import ConfirmModal from "@/features/shared/components/ConfirmModal.vue";
import modalState from "@/features/shared/services/modalState";

import {useTeamStore} from "@/stores/teamStore.js";

import plusIcon from "@/assets/plus.png";
import router from "@/router/router";
import {onBeforeMount} from "vue";

const teamStore = useTeamStore();

const fetchTeammates = async () => {
  await teamStore.getTeammateWithinTeam(teamStore.getCurrentTeam);
};

onBeforeMount(async () => {
  fetchTeammates();
});

const removeUserFromTeam = (id: number, informations: string) => {
  teamStore.setTeammateToDelete(id);
  modalState.setInformation(informations);
  modalState.changeVisibility();
};

const modalAccept = () => {
  teamStore.deleteTeammateFromTeam(teamStore.getTeammateToDelete);
  setTimeout(() => {
    fetchTeammates();
  }, 150);
};
</script>

<template>
  <confirm-modal
    v-show="modalState.isShowed"
    @modal-accept="modalAccept" />
  <div class="captain-view">
    <h1 class="title">Team Members</h1>
    <h2 class="text">Manage your team members here</h2>
    <hr class="line" />

    <side-bar-button
      v-bind:inner-text="'Add Teammate'"
      v-bind:icon-path="plusIcon"
      @click.prevent="router.push({path: `invitation`})" />

    <div class="team-mate-list">
      <team-mate
        :team-mate="teamMate"
        v-for="teamMate in teamStore.getTeammateList"
        :key="teamMate.id"
        @RemoteTeammate="removeUserFromTeam" />
    </div>
  </div>
</template>

<style lang="scss">
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap");

.captain-view {
  padding: 30px;
  font-family: "Inter", sans-serif;
}
.title {
  font-size: 38px;
}
.text {
  font-size: 18px;
  color: #787878;
  margin-bottom: 20px;
}
.line {
  width: 80%;
  background-color: #efefefed;

  margin-bottom: 1rem;
}
.team-mate-list {
  padding: 50px;
  display: flex;
  flex-direction: column;
  align-items: center;

  gap: 3rem;
}
</style>
