<script setup lang="ts">
import router from "@/router/router";
import plusIcon from "@/assets/plus.png";
import { onBeforeMount } from "vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import { useCaptainStore } from "@/stores/captainStore";
import CaptainElement from "../components/CaptainElement.vue";

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
      <SideBarButton
        v-bind:inner-text="'To invite a captain'"
        v-bind:icon-path="plusIcon"
        @click.prevent="router.push({ path: 'invitation' })" />

      <div class="captain-list">
        <captain-element
          :captain="captain"
          v-for="captain in captainStore.getCaptainList"
          :key="captain.id" />
      </div>
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
  display: flex;
  flex-direction: column;
  gap: 3rem;
  padding: 2rem;
  align-items: center;
}
</style>
