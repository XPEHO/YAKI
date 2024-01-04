<script setup lang="ts">
import { onBeforeMount } from "vue";

import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import { useCaptainStore } from "@/stores/captainStore";
import { useSelectedRoleStore } from "@/stores/selectedRole";
import { INVITEDROLE } from "@/constants/pathParam.enum";

import PageContentHeader from "@/ui/views/PageContentHeader.vue";
import UserList from "@/ui/components/UserList.vue";

const captainStore = useCaptainStore();
const selectedRoleStore = useSelectedRoleStore();

onBeforeMount(async () => {
  await captainStore.setAllCaptainsByCustomerId(selectedRoleStore.getCustomerIdSelected);
});
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header :invited-role="INVITEDROLE.captain" />
    </template>
    <template #content>
      <user-list
        :userList="captainStore.getCaptainList"
        :isUsingTeamDescription="false"
      />
    </template>
  </page-content-layout>
</template>

<style scoped lang="scss">
.captain-list {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  padding: 2rem;
  align-items: center;
}
</style>
