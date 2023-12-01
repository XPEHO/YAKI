<script setup lang="ts">
import PageContentHeader from "@/ui/views/captain/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import {useTeammateStore} from "@/stores/teammateStore";
import UserList from "@/ui/components/UserList.vue";

const teammateStore = useTeammateStore();
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header />
    </template>
    <template #content>
      <user-list
        :userList="teammateStore.teammates"
        :isUsingTeamDescription="true" />
    </template>
  </page-content-layout>
</template>
