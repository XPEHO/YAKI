<script setup lang="ts">
import PageLayout from "@/layouts/PageLayout.vue";
import SideBarContent from "@/features/shared/components/SideBarContent.vue";

import {RouterView} from "vue-router";
</script>

<template>
  <page-layout>
    <template v-slot:sidebarContent>
      <side-bar-content />
    </template>

    <template v-slot:pageContent>
      <router-view />
    </template>
  </page-layout>
</template>
