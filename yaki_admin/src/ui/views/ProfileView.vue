<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import router from "@/router/router";
import buttonSecondary from "@/ui/components/buttons/ButtonSecondary.vue";

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
      <p class="text_default__Team_name">Coming Soon</p>
      <buttonSecondary
        text="Log off"
        @click.prevent="logOff"
      />
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
