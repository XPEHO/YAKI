<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import InviteMemberTutorial from "@/ui/components/tutoriels/InviteMemberTutorial.vue";
import { useTeammateStore } from "@/stores/teammateStore";
import UserList from "@/ui/components/UserList.vue";
import { INVITEDROLE } from "@/constants/pathParam.enum";
import { useTeamStore } from "@/stores/teamStore";
import { onBeforeMount } from "vue";

const teammateStore = useTeammateStore();
const teamStore = useTeamStore();

//before mount, select first team from fetched team list (fetched in the router the first time the user connect)
onBeforeMount(async () => {
  // automaticaly select first team right after team fetch on component mount ( right after the first connexion)
  if (
    (teamStore.getTeamSelected.id === null || teamStore.getTeamSelected.id === undefined) &&
    teamStore.getTeamListByCaptain &&
    teamStore.getTeamListByCaptain.length > 0
  ) {
    teamStore.setTeamSelectedAndFetchTeammates(teamStore.getTeamListByCaptain[0]);
  }
});
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header
        :is-team-management="true"
        :invited-role="INVITEDROLE.teammate"
      />
    </template>
    <template #content>
      <user-list
        v-if="teammateStore.teammates.length > 0"
        :userList="teammateStore.teammates"
        :isUsingTeamDescription="true"
      />

      <invite-member-tutorial v-else />
    </template>
  </page-content-layout>
</template>
