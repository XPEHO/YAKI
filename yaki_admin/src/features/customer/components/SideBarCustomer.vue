<script setup lang="ts">
import vector from "@/assets/Vector.png";
import security from "@/assets/security.png";
import plusIcon from "@/assets/plus.png";
import router from "@/router/router";

import SideBarElement from "@/features/shared/components/SideBarCategoryElement.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";

const navigateTo = (route: string) => {
  router.push({path: route, replace: true});
};
</script>

<template>
  <nav class="navbar">
    <side-bar-element
      v-bind:innerText="'Manage Captains'"
      v-bind:iconPath="security"
      v-bind:isSelected="true"
      @click="navigateTo('/customer/manage-captain')" />

    <side-bar-element
      v-bind:innerText="'Manage Teams'"
      v-bind:iconPath="vector"
      v-bind:isSelected="true"
      @click="navigateTo('/customer/manage-team')" />
    <side-bar-button
      v-bind:inner-text="'Add team'"
      v-bind:icon-path="plusIcon"
      @click="() => {}" />
  </nav>
</template>

<style lang="scss">
.navbar {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  font-size: 1rem;
  text-decoration: none;
}
</style>
