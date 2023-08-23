<script setup lang="ts">
import {onBeforeMount} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";
import router from "@/router/router";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import UserCard from "@/features/shared/components/UserCard.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import ModalValidation from "@/features/shared/popup/ModalValidation.vue";
import modalValidationState from "@/features/shared/services/modalValidationState";

import plusIcon from "@/assets/images/plus.png";
import { useTeammateStore } from "@/stores/teammateStore";

const teamStore = useTeamStore();
const teammateStore = useTeammateStore();

const fetchTeammates = async () => {
  await teammateStore.setTeammatesWithinTeam(teamStore.getTeamId);
};

onBeforeMount(async () => {
  fetchTeammates();
});

const removeUserFromTeam = (id: number, informations: string) => {
  teammateStore.setTeammateToDelete(id);

  modalValidationState.setInformation(informations);
  modalValidationState.changeVisibility();
};

const validationModalAccept = () => {
  teammateStore.deleteTeammateFromTeam(teammateStore.getTeammateToDelete);
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

      <user-card
        v-for="teammate in teammateStore.getTeammateList"
        :user="teammate"
        :key="teammate.id"
        @removeUser="removeUserFromTeam" />
    </template>
  </page-content-layout>
</template>
