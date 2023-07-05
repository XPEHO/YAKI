<script setup lang="ts">
import PageLayout from "@/features/shared/layouts/PageLayout.vue";
import SideBarCaptainContent from "@/features/captain/components/SideBarCaptainContent.vue";

import {RouterView} from "vue-router";
</script>

<template>
  <page-layout>
    <template v-slot:sidebarContent>
      <side-bar-captain-content />
    </template>

    <template v-slot:pageContent>
      <router-view />
    </template>
  </page-layout>
</template>

<style lang="scss"></style>
