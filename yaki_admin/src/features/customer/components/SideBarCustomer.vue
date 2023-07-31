<script setup lang="ts">
import vector from "@/assets/Vector.png";
import security from "@/assets/security.png";
import plusIcon from "@/assets/plus.png";

import SideBarElement from "@/features/shared/components/SideBarElement.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
</script>

<template>
  <nav class="navbar">
    <side-bar-element
      v-bind:innerText="'Manage Captains'"
      v-bind:iconPath="security"
      v-bind:isSelected="true" />
    <side-bar-element
      v-bind:innerText="'Manage Teams'"
      v-bind:iconPath="vector"
      v-bind:isSelected="true" />

    <side-bar-button
      v-bind:inner-text="'Add captain'"
      v-bind:icon-path="plusIcon"
      @click="" />
  </nav>
</template>

<style lang="scss">
.navbar {
  max-width: 30vw;
  height: 100vh;
  background-color: #fafafa;
  padding-block: 2rem;
  display: flex;
  flex-direction: column;
  gap: 2rem;
  font-size: 1rem;
}
</style>
