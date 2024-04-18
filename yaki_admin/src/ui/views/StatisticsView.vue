<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import buttonPrimary from "@/ui/components/buttons/ButtonPrimary.vue";

import { statisticsService } from "@/services/statistics.service";
import { useSelectedRoleStore } from "@/stores/selectedRole";

const selectedRoleStore = useSelectedRoleStore();

const downloadCsv = async () => {
  const customerId = selectedRoleStore.getCustomerIdSelected;

  try {
    const url = await statisticsService.getStatisticsCsv(customerId);
    const link = document.createElement("a");
    link.href = url;
    link.download = "statistics.csv";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  } catch (error) {
    console.error("Error while getting CSV :", error);
  }
};
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header title="Statistics" />
    </template>
    <template #content>
      <div>
        <buttonPrimary
          text="Download in CSV format"
          @click.prevent="downloadCsv"
        />
      </div>
    </template>
  </page-content-layout>
</template>

<style scoped>
div {
  padding: 1rem;
  display: flex;
  justify-content: center;

  & button {
    width: 20rem;
  }
}
</style>
