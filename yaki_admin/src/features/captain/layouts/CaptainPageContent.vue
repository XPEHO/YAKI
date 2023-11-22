<script setup lang="ts">
import {onBeforeMount} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";

import PageContentLayout from "@/global-layouts/PageContentLayout.vue";
import UserInfoCard from "@/components/UserInfoCard.vue";
import PageContentHeader from "@/features/captain/layouts/PageContentHeader.vue";
import {useTeammateStore} from "@/stores/teammateStore";

const teamStore = useTeamStore();
const teammateStore = useTeammateStore();

onBeforeMount(async () => {
  await teammateStore.setListOfTeammatesWithinTeam(teamStore.getSelectedTeamId);
});
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header />
    </template>
    <template #content>
      <section class="user-list__container">
        <p v-if="teammateStore.getTeammateList.length > 0">Teammates :</p>
        <user-info-card
          v-for="teammate in teammateStore.getTeammateList"
          :user="teammate"
          :key="teammate.id" />
      </section>
    </template>
  </page-content-layout>
</template>

<style scoped lang="scss">
$border-radius: 24px;
.user-list__container {
  border-radius: $border-radius;

  > p {
    color: #7d818c;
    font-size: 16px;
    font-style: normal;
    font-weight: 400;
    line-height: 100%;

    padding-block-end: 16px;
  }

  article:nth-of-type(1) {
    border-top-left-radius: $border-radius;
    border-top-right-radius: $border-radius;
  }

  article:last-of-type {
    border-bottom-left-radius: $border-radius;
    border-bottom-right-radius: $border-radius;
  }
}
</style>
