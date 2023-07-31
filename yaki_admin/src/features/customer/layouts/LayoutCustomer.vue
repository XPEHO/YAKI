<script setup lang="ts">
import router from "@/router/router";
import plusIcon from "@/assets/plus.png";
import ManageTeams from "../components/ManageTeams.vue";
import ManageCaptains from "../components/ManageCaptains.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import HeaderYaki from "@/features/shared/components/HeaderYaki.vue";
import SideBarCustomer from "../components/SideBarCustomer.vue";
</script>

<template>
  <header-yaki />
  <div class="layout-customer">
    <SideBarCustomer />
    <div class="customer-view">
      <SideBarButton
        v-bind:inner-text="'Add captain'"
        v-bind:icon-path="plusIcon"
        @click.prevent="router.push({ path: 'invitation' })" />
      <ManageCaptains />
      <ManageTeams />
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
