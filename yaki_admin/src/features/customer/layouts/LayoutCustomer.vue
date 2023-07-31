<script setup lang="ts">

import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import plusIcon from "@/assets/plus.png";
import SideBarElement from "@/features/shared/components/SideBarElement.vue";
import router from "@/router/router";
</script>
<template>
  <div class="customer-view">
    <side-bar-element
      v-bind:inner-text="'Manage teams'"
      v-bind:icon-path="plusIcon"
      @click="currentComponent = 'ManageTeams'" />
    <side-bar-element
      v-bind:inner-text="'Manage captains'"
      v-bind:icon-path="plusIcon"
      @click="currentComponent = 'ManageCaptains'" />
    <SideBarButton
      v-bind:inner-text="'Add captains'"
      v-bind:icon-path="plusIcon"
      @click.prevent="router.push({ path: `invitation` })" />
    <component :is="currentComponent" />
  </div>
</template>
<style lang="scss"></style>
