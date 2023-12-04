<script setup lang="ts">
import PageContentHeader from "@/ui/views/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import {useTeammateStore} from "@/stores/teammateStore";
import UserList from "@/ui/components/UserList.vue";
import {INVITEDROLE} from "@/constants/pathParam.enum";
import {useTeamStore} from "@/stores/teamStore";
import {onBeforeMount} from "vue";

const teammateStore = useTeammateStore();
const teamStore = useTeamStore();

//before mount, select first team from fetched team list (fetched in the router the first time the user connect)
onBeforeMount(async () => {
  // automaticaly select first team right after team fetch on component mount ( right after the first connexion)
  if (teamStore.getTeamList && teamStore.getTeamList.length > 0) {
    teamStore.setTeamInfoAndFetchTeammates(teamStore.getTeamList[0]);
  }
});
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
