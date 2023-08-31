<script setup lang="ts">
import {onBeforeMount} from "vue";

import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import {useTeamStore} from "@/stores/teamStore";
import modalState from "@/features/shared/modal/services/modalState";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import TeamWithCaptainCard from "@/features/customer/components/TeamWithCaptainCard.vue";
import plusIcon from "@/assets/images/plus.png";
import {useCaptainStore} from "@/stores/captainStore";
import {useSelectedRoleStore} from "@/stores/selectedRole";

const teamStore = useTeamStore();
const captainStore = useCaptainStore();
const selectedRoleStore = useSelectedRoleStore();

onBeforeMount(async () => {
  await teamStore.setTeamsFromCustomer();
  await captainStore.setAllCaptainsByCustomerId(selectedRoleStore.getCustomerIdSelected);
});

const customerTeamCreation = () => {
  modalState.switchModalVisibility(true, MODALMODE.teamCreateCustomer);
};
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
        v-bind:inner-text="'Create a team'"
        v-bind:icon-path="plusIcon"
        @click.prevent="customerTeamCreation" />

      <team-with-captain-card
        v-for="team in teamStore.getTeamList"
        :team-content="team"
        :key="team.id" />
    </template>
  </page-content-layout>
</template>
