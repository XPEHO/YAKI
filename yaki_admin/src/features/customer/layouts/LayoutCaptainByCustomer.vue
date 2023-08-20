<script setup lang="ts">
import router from "@/router/router";
import {onBeforeMount} from "vue";
import {useCaptainStore} from "@/stores/captainStore";

import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import CaptainElement from "../components/CaptainElement.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import plusIcon from "@/assets/plus.png";

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
      <header-content-page
        v-bind:title="'Captains List'"
        v-bind:text="'Manage your captains here'" />

      <SideBarButton
        v-bind:inner-text="'To invite a captain'"
        v-bind:icon-path="plusIcon"
        @click.prevent="router.push({path: 'invitation'})" />

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
  gap: 2rem;
  padding: 2rem;
  align-items: center;
}
</style>
