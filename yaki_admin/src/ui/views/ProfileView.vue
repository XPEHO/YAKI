<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import buttonSecondary from "@/ui/components/buttons/ButtonSecondary.vue";
import LanguageSwitch from "../components/LanguageSwitch.vue";
import { useAuthStore } from "@/stores/authStore";

const logOff = () => {
  const authStore = useAuthStore();
  authStore.logout();
};
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header title="Profile" />
    </template>
    <template #content>
      <buttonSecondary
        :text="$t('buttons.logout')"
        @click.prevent="logOff"
      />
      <LanguageSwitch />
    </template>
  </page-content-layout>
</template>

<style scoped lang="scss">
button {
  max-width: 10rem;
  margin: 2rem;
  align-self: center;
}
</style>
