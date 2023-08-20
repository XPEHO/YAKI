<script setup lang="ts">
import PageLayout from "@/global-layouts/PageLayout.vue";
import SideBarCustomer from "@/features/customer/components/SideBarCustomer.vue";
import {RouterView} from "vue-router";
</script>

<template>
  <page-layout>
    <template v-slot:sidebarContent>
      <side-bar-customer />
    </template>

    <template v-slot:pageContent>
      <router-view />
    </template>
  </page-layout>
</template>
