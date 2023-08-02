<script setup lang="ts">
import router from "@/router/router";
import plusIcon from "@/assets/plus.png";
import { onBeforeMount } from "vue";

import { useCaptainStore } from "@/stores/captainStore";

const captainStore = useCaptainStore();

const fetchCaptains = async () => {
  await captainStore.getAllCaptainsByCustomerId(captainStore.getCustomerId);
};

onBeforeMount(async () => {
  fetchCaptains();
});
</script>

<template>
  <div class="layout-captain">
    <div class="customer-view-captains">
      <h1 class="title">Captains List</h1>
      <h2 class="text">Manage your captains here</h2>
      <hr class="line" />

      <div class="captain-list">
        <div
          :captain="captain"
          v-for="captain in captainStore.getCaptainList"
          :key="captain.id">
          {{ captain.firstname }}
          {{ captain.lastname }}
          {{ captain.email }}
        </div>
      </div>
      <SideBarButton
        v-bind:inner-text="'To invite a captain'"
        v-bind:icon-path="plusIcon"
        @click.prevent="router.push({ path: 'invitation' })" />
    </div>
  </div>
</template>

<style lang="scss">
.customer-view {
  padding: 2rem;
}
.customer-view-captains {
  padding: 2rem;
}
.captain-list {
  padding: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3rem;
}
</style>
