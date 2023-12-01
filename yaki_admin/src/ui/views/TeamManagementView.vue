<script setup lang="ts">
import PageContentHeader from "@/ui/views/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import {useTeammateStore} from "@/stores/teammateStore";
import UserList from "@/ui/components/UserList.vue";
import {INVITEDROLE} from "@/constants/pathParam";

const teammateStore = useTeammateStore();
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header
        :is-team-management="true"
        :invited-role="INVITEDROLE.teammate" />
    </template>
    <template #content>
      <user-list
        :userList="teammateStore.teammates"
        :isUsingTeamDescription="true" />
    </template>
  </page-content-layout>
</template>
