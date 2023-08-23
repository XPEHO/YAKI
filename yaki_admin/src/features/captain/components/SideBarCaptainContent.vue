<script setup lang="ts">
import {onBeforeMount} from "vue";
import SideBarTeamListElement from "@/features/shared/components/SideBarTeamListElement.vue";
import SideBarElement from "@/features/shared/components/SideBarCategoryElement.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import ModalTeam from "@/features/shared/popup/ModalTeam.vue";

import {useTeamStore} from "@/stores/teamStore.js";

import isTeamSelected from "@/features/shared/services/isSelectedTeamActive";
import modalState from "@/features/shared/services/modalTeamState";

import vector from "@/assets/images/Vector.png";
import plusIcon from "@/assets/images/plus.png";
import modalTeamState from "@/features/shared/services/modalTeamState";
import { useRoleStore } from "@/stores/roleStore";

const teamStore = useTeamStore();
const roleStore = useRoleStore();

const fetchTeams = async () => {
  await teamStore.setTeamsFromCaptain(roleStore.getCaptainsId);
};

//before mount, fetch teams, select first team from the saved list, get team name, fetch teammates.
onBeforeMount(async () => {
  await fetchTeams();
  // automaticaly select first team right after team fetch, and save name
  if(teamStore.getTeamList.length === 0) return;
  isTeamSelected.setTeamId(teamStore.getTeamList[0].id);
  teamStore.setTeamSelectedId(teamStore.getTeamList[0].id);
  teamStore.setTeamName(teamStore.getTeamList[0].teamName);
  //directly fetch teammate from the first team
});

const onClickSelectTeam = (id: number, teamName: string) => {
  // style change on selection
  isTeamSelected.setTeamId(id);
  // for input value change for creation or edition
  modalTeamState.setSelectedTeamName(teamName);
  teamStore.setTeamSelectedId(id);
  // teamStore
  teamStore.setTeamName(teamName);
};

// add team button press to open modal
const onClickAddTeam = () => {
  modalState.setModalMode(0);
  modalState.visibilitySwitch();
};

// modal accept button press
const teamModalAccept = async (teamName: string) => {
  switch (modalState.modalMode) {
    case 0:
      //create a team with the captainId of the captain connected
      teamStore.createTeam(roleStore.getCaptainsId[0], teamName,);
      break;
    case 1:
      teamStore.updateTeam(teamStore.getTeamId, teamName);
      break;
    case 2:
      teamStore.deleteTeam(teamStore.getTeamId);
      break;
  }
  // fetch to trigger re-render
  setTimeout(() => {
    fetchTeams();
  }, 100);
};
</script>

<template>
  <modal-team
    v-show="modalState.isShowed"
    @modal-team="teamModalAccept" />

  <side-bar-element
    v-bind:innerText="'My teams'"
    v-bind:iconPath="vector"
    v-bind:isSelected="true" />

  <side-bar-button
    v-bind:inner-text="'Add team'"
    v-bind:icon-path="plusIcon"
    @click="onClickAddTeam" />

  <section class="team-list">
    <side-bar-team-list-element
      v-for="(team, index) in teamStore.getTeamList"
      :key="index"
      v-bind:id="team.id"
      v-bind:teamName="team.teamName"
      @click.prevent="() => onClickSelectTeam(team.id, team.teamName)" />
  </section>
</template>
