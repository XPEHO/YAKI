<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import router from "@/router/router";
import buttonSecondary from "@/ui/components/buttons/ButtonSecondary.vue";
import LanguageSwitch from "../components/LanguageSwitch.vue";

const logOff = () => {
  router.push("/");
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
