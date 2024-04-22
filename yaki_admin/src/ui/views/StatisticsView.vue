<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import buttonPrimary from "@/ui/components/buttons/ButtonPrimary.vue";

import { statisticsService } from "@/services/statistics.service";
import { useSelectedRoleStore } from "@/stores/selectedRole";

import { useI18n } from "vue-i18n";
const { t } = useI18n();
const cvsFileName = `${t("sidebar.statistics")}.csv`;

const selectedRoleStore = useSelectedRoleStore();

const downloadCsv = async () => {
  const customerId = selectedRoleStore.getCustomerIdSelected;

  try {
    const url = await statisticsService.getStatisticsCsv(customerId);
    const link = document.createElement("a");
    link.href = url;
    link.download = cvsFileName;
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
      <page-content-header :title="$t('sidebar.statistics')" />
    </template>
    <template #content>
      <div>
        <buttonPrimary
          :text="$t('buttons.downloadCsv')"
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
