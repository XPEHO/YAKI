<script setup lang="ts">
import router from "@/router/router";
import {onBeforeMount} from "vue";
import {useCaptainStore} from "@/stores/captainStore";

import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import UserCard from "@/features/shared/components/UserCard.vue";
import plusIcon from "@/assets/images/plus.png";

const captainStore = useCaptainStore();

const fetchCaptains = async () => {
  await captainStore.getAllCaptainsByCustomerId(captainStore.getCustomerId);
};

onBeforeMount(async () => {
  fetchCaptains();
});
</script>

<template>
  <header-content-page
    v-bind:title="'Captains List'"
    v-bind:text="'Manage your captains here'" />

  <SideBarButton
    v-bind:inner-text="'To invite a captain'"
    v-bind:icon-path="plusIcon"
    @click.prevent="router.push({path: 'invitation'})" />

  <div class="captain-list">
    <user-card
      v-for="captain in captainStore.getCaptainList"
      :user="captain"
      :key="captain.id" />
  </div>
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
