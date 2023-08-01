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
    <div class="customer-view">
      <SideBarButton
        v-bind:inner-text="'To invite a captain'"
        v-bind:icon-path="plusIcon"
        @click.prevent="router.push({ path: 'invitation' })" />

      <div class="customer-view-captains">
        <h1 class="title">Captains List</h1>
        <h2 class="text">Manage your captains here</h2>
        <hr class="line" />
        <div class="captain-list">
          <captain
            :captain="captain"
            v-for="captain in captainStore.getCaptainList"
            :key="captain.id" />
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap");
.customer-view {
  padding: 2rem;
  font-family: "Inter", sans-serif;
  width: 70vw;
}
.layout-customer {
  display: flex;
  flex-direction: rows;
}
.customer-view-captains {
  padding: 2rem;
  font-family: "Inter", sans-serif;
}
.title {
  font-size: 2rem;
}
.text {
  font-size: 1.2rem;
  color: #787878;
  margin-bottom: 2rem;
}
.line {
  width: 80vw;
  background-color: #efefefed;
  margin-bottom: 1rem;
}
.captain-list,
.team-list {
  padding: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3rem;
}
</style>
