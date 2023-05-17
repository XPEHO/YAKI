<script setup lang="ts">
import PageLayout from '@/shared/layouts/PageLayout.vue';
import SideBarCaptainContent from '../components/SideBarCaptainContent.vue';
import ContentCaptain from '@/features/captain/layouts/ContentCaptain.vue';
</script>

<template>
  <page-layout>
    <template v-slot:sidebarContent>
      <side-bar-captain-content />
    </template>

    <template v-slot:pageContent>
      <content-captain />
    </template>
  </page-layout>
</template>

<style lang="scss"></style>
