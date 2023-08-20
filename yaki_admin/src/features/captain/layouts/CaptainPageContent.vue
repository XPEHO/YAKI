<script setup lang="ts">
import {onBeforeMount} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";
import router from "@/router/router";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import TeamMate from "../components/teamMate.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import ModalValidation from "@/features/shared/popup/ModalValidation.vue";
import modalValidationState from "@/features/shared/services/modalValidationState";

import plusIcon from "@/assets/images/plus.png";

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

      <team-mate
        :team-mate="teamMate"
        v-for="teamMate in teamStore.getTeammateList"
        :key="teamMate.id"
        @RemoteTeammate="removeUserFromTeam" />
    </template>
  </page-content-layout>
</template>
