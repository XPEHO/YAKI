<script setup lang="ts">
import {onBeforeMount, reactive} from "vue";
import TeamListElement from "@/features/captain/components/TeamListElement.vue";
import SideBarElement from "@/features/shared/components/SideBarElement.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";

import type {TeamType} from "@/models/team.type";
import {teamService} from "@/services/team.service";
import {useTeamStore} from "@/stores/teamStore.js";

import isTeamSelected from "../services/isActiveTeam";

import vector from "@/assets/Vector.png";
import plusIcon from "@/assets/plus.png";

const store = useTeamStore();
const teams = reactive({
  list: [] as TeamType[],
});
onBeforeMount(async () => {
  teams.list = await teamService.getAllTeamsWithinCaptain(2);
  // automaticaly select first team right after team fetch, and save name
  isTeamSelected.setTeam(teams.list[0].id);
  isTeamSelected.setTeamName(teams.list[0].teamName);
  //directly fetch teammate from the first team
  store.getTeammateWithinTeam(teams.list[0].id);
});

const selectedTeam = (id: number) => {
  isTeamSelected.setTeam(id);
  store.getTeammateWithinTeam(id);

  //save team name on click
  for (const team of teams.list) {
    if (team.id === id) {
      isTeamSelected.setTeamName(team.teamName);
      break;
    }
  }
};
</script>

<template>
  <side-bar-element
    v-bind:innerText="'My teams'"
    v-bind:iconPath="vector"
    v-bind:isSelected="true" />

  <section class="team-list">
    <team-list-element
      v-for="(team, index) in teams.list"
      :key="index"
      @click="() => selectedTeam(team.id)"
      v-bind:id="team.id"
      v-bind:teamName="team.teamName" />
  </section>
  <side-bar-button
    v-bind:inner-text="'Add team'"
    v-bind:icon-path="plusIcon" />
</template>

<style lang="scss">
.team-list {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}
</style>
@/models/team.type
