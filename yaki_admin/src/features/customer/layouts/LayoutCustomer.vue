import { SideBarButton } from '@/components/SideBarButton.vue';
<script setup lang="ts">
// Importing necessary modules and types
import SideBarButton from "../../../components/SideBarButton.vue";
import plusIcon from "../../../../src/assets/plus.png";
</script>

<template>
  < class="customer-view">
  <h1 class="title">Customer</h1>
  <h2 class="text">Manage your customer here</h2>
  <hr class="line" />

  <side-bar-button
    v-bind:inner-text="'Add Customer'"
    v-bind:icon-path="plusIcon"
    @click.prevent="router.push({ path: `invitation` })" />

  <div>
    <captain
      :captain="captain"
      v-for="captain in captainStore.getCaptainList"
      :key="captain.id"
      @RemoteCaptain="removeUserFromTeam" />
  </div>
</template>
