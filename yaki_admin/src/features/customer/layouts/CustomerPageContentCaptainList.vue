<script setup lang="ts">
import router from "@/router/router";
import {onBeforeMount} from "vue";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import UserCard from "@/features/shared/components/UserCard.vue";
import plusIcon from "@/assets/images/plus.png";
import {useCaptainStore} from "@/stores/captainStore";
import {useSelectedRoleStore} from "@/stores/selectedRole";

const captainStore = useCaptainStore();
const selectedRoleStore = useSelectedRoleStore();

onBeforeMount(async () => {
  await captainStore.setAllCaptainsByCustomerId(selectedRoleStore.getCustomerIdSelected);
});
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <header-content-page
        v-bind:title="'Captains List'"
        v-bind:text="'Manage your captains :'" />
    </template>
    <template #content>
      <SideBarButton
        v-bind:inner-text="'Invite a captain'"
        v-bind:icon-path="plusIcon"
        @click.prevent="router.push({path: 'invitation'})" />

      <user-card
        v-for="captain in captainStore.getCaptainList"
        :user="captain"
        :key="captain.id" />
    </template>
  </page-content-layout>
</template>

<style lang="scss">
.captain-list {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  padding: 2rem;
  align-items: center;
}
</style>
