<script setup lang="ts">
import PageLayout from "@/shared/layouts/PageLayout.vue";
import SideBarCaptainContent from "../components/SideBarCaptainContent.vue";
import ContentCaptain from "@/features/captain/layouts/ContentCaptain.vue";
</script>

<template>
  <PageLayout>
    <template v-slot:slidebarContent>
      <SideBarCaptainContent />
    </template>

    <template v-slot:content>
      <ContentCaptain />
    </template>
  </PageLayout>
</template>

<style lang="scss"></style>
