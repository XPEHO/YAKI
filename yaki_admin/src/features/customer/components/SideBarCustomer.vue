<script setup lang="ts">
import vector from "@/assets/images/Vector.png";
import security from "@/assets/images/security.png";
import router from "@/router/router";
import plusIcon from "@/assets/images/plus.png";

import SideBarElement from "@/features/shared/components/SideBarCategoryElement.vue";

const navigateTo = (route: string) => {
  router.push({path: route, replace: true});
};
</script>

<template>
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

  <side-bar-element
    v-bind:inner-text="'Grant admin rights'"
    v-bind:icon-path="plusIcon"
    @click="navigateTo('/customer/admin-invitation')" />
</template>
