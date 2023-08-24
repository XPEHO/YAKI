<script setup lang="ts">
import {onBeforeMount} from "vue";
import SideBarTeamsListElement from "@/features/shared/components/SideBarTeamsListElement.vue";
import SideBarElement from "@/features/shared/components/SideBarCategoryElement.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import modalState from "@/features/shared/services/modalState";
import {MODALMODE} from "@/features/shared/services/modalMode";

import {useTeamStore} from "@/stores/teamStore.js";
import {selectTeamAndFetchUsers} from "@/utils/teamList";

import vector from "@/assets/images/Vector.png";
import plusIcon from "@/assets/images/plus.png";
import {useRoleStore} from "@/stores/roleStore";

const teamStore = useTeamStore();
const roleStore = useRoleStore();

const fetchTeams = async () => {
  await teamStore.setTeamsFromCaptain(roleStore.getCaptainsId);
};

//before mount, fetch teams, select first team from the saved list, get team name, fetch teammates.
onBeforeMount(async () => {
  await fetchTeams();
  // automaticaly select first team right after team fetch, and save name
  selectTeamAndFetchUsers(teamStore.getTeamList[0].id);
});

const onClickSelectTeam = (id: number) => {
  selectTeamAndFetchUsers(id);
};

// add team button press to open modal
const onClickAddTeam = () => {
  modalState.switchModalVisibility(true, MODALMODE.teamCreate);
};
</script>

<template>
  <side-bar-element
    v-bind:innerText="'My teams'"
    v-bind:iconPath="vector"
    v-bind:isSelected="true" />

  <side-bar-button
    v-bind:inner-text="'Add team'"
    v-bind:icon-path="plusIcon"
    @click="onClickAddTeam" />

  <section class="team-list">
    <side-bar-teams-list-element
      v-for="(team, index) in teamStore.getTeamList"
      :key="index"
      v-bind:id="team.id"
      v-bind:teamName="team.teamName"
      @click.prevent="() => onClickSelectTeam(team.id)" />
  </section>
</template>
