<script setup lang="ts">
import PageContentHeader from "@/features/captain/layouts/PageContentHeader.vue";
import PageContentLayout from "@/layouts/PageContentLayout.vue";
import UserInfoCard from "@/components/UserInfoCard.vue";
import { useTeammateStore } from "@/stores/teammateStore";
import { useModalStore } from "@/stores/modalStore";

const teammateStore = useTeammateStore();
const modalStore = useModalStore();

</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header />
    </template>
    <template #content>
      <section class="user-list__container">
        <p>Team description : {{ modalStore.getTeamDescriptionInputValue }}</p>
        <p
          v-if="
            teammateStore.getTeammateList &&
            teammateStore.getTeammateList.length > 0
          ">
          Teammates :
        </p>
        <section class="user-list__in-team-container">
          <user-info-card
            v-for="teammate in teammateStore.getTeammateList"
            :user="teammate"
            :key="teammate.id" />
        </section>
      </section>
    </template>
  </page-content-layout>
</template>

<style scoped lang="scss">
$border-radius: 24px;
.user-list__container {
  padding-block-end: 10rem;

  > p:nth-of-type(1) {
    color: #7d818c;
    font-family: Rubik;
    font-size: 15px;
    font-style: normal;
    font-weight: 400;
    line-height: 150%;

    padding-block-end: 32px;
  }

  > p:nth-of-type(2) {
    color: #7d818c;
    font-size: 16px;
    font-style: normal;
    font-weight: 400;
    line-height: 100%;

    padding-block-end: 16px;
  }

  .user-list__in-team-container {
    border-radius: $border-radius;
    article:nth-of-type(1) {
      border-top-left-radius: $border-radius;
      border-top-right-radius: $border-radius;
    }

    article:last-of-type {
      border-bottom-left-radius: $border-radius;
      border-bottom-right-radius: $border-radius;
    }
  }
}
</style>
