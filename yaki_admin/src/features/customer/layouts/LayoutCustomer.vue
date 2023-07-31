<script setup lang="ts">
import { ref } from "vue";
import router from "@/router/router";
import plusIcon from "@/assets/plus.png";

const currentComponentTeams = ref("");
const currentComponentCaptains = ref("");

const handleClickTeams = () => {
  currentComponentTeams.value = "ManageTeams";
};

const handleClickCaptains = () => {
  currentComponentCaptains.value = "ManageCaptains";
};
</script>

<template>
  <div class="customer-view">
    <SideBarElement
      v-bind:inner-text="'Manage teams'"
      @click="currentComponentTeams = 'ManageTeams'" />

    <SideBarElement
      v-bind:inner-text="'Manage captains'"
      @click="currentComponentCaptains = 'ManageCaptains'" />

    <SideBarButton
      v-bind:inner-text="'Add captains'"
      v-bind:icon-path="plusIcon"
      @click.prevent="router.push({ path: 'invitation' })" />
  </div>
</template>

<style lang="scss"></style>
