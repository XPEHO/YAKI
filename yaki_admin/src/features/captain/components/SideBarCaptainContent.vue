<script setup lang="ts">
import {onBeforeMount} from "vue";
import TeamListElement from "@/features/captain/components/TeamListElement.vue";
import SideBarElement from "@/features/shared/components/SideBarElement.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import ModalTeam from "@/features/shared/components/ModalTeam.vue";

import {useTeamStore} from "@/stores/teamStore.js";

import isTeamSelected from "../services/isActiveTeam";
import modalState from "@/features/shared/services/modalTeamState";

import vector from "@/assets/Vector.png";
import plusIcon from "@/assets/plus.png";
import modalTeamState from "@/features/shared/services/modalTeamState";

const store = useTeamStore();

const fetchTeams = async () => {
  await store.getTeamsFromCaptain(store.getCaptainId);
};

//before mount, fetch teams, select first team from the saved list, get team name, fetch teammates.
onBeforeMount(async () => {
  await fetchTeams();
  // automaticaly select first team right after team fetch, and save name
  isTeamSelected.setTeam(store.getTeamList[0].id);
  store.setTeamName(store.getTeamList[0].teamName);
  //directly fetch teammate from the first team
  store.getTeammateWithinTeam(store.getTeamList[0].id);
});

const onClickSelectTeam = (id: number, teamName: string) => {
  // style change on selection
  isTeamSelected.setTeam(id);
  // for input value change for creation or edition
  modalTeamState.setSelectedTeamName(teamName);
  // teamStore
  store.setTeamName(teamName);
  store.getTeammateWithinTeam(id);
};

// add team button press to open modal
const onClickAddTeam = () => {
  modalState.setModalMode(0);
  modalState.changeVisibility();
};

// modal accept button press
const teamModalAccept = async (teamName: string) => {
  switch (modalState.modalMode) {
    case 0:
      store.createTeam(store.getCaptainId, teamName);
      break;
    case 1:
      store.updateTeam(store.getTeamId, store.getCaptainId, teamName);
      break;
    case 2:
      store.deleteTeam(store.getTeamId);
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

  <section class="team-list">
    <team-list-element
      v-for="(team, index) in store.getTeamList"
      :key="index"
      v-bind:id="team.id"
      v-bind:teamName="team.teamName"
      @click.prevent="() => onClickSelectTeam(team.id, team.teamName)"
      @team-edit="" />
  </section>
  <side-bar-button
    v-bind:inner-text="'Add team'"
    v-bind:icon-path="plusIcon"
    @click="onClickAddTeam" />
</template>

<style lang="scss">
.team-list {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}
</style>
