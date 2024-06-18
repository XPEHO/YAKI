<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header :title="$t('sidebar.teams')" />
    </template>
    <template #content>
      <p>{{ $t("general.comingSoon") }}</p>
    </template>
  </page-content-layout>
</template>
