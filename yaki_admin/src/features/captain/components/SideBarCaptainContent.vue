<script setup lang="ts">
import {onBeforeMount} from "vue";
import SideBarTeamsListElement from "@/features/shared/components/SideBarTeamsListElement.vue";
import SideBarElement from "@/features/shared/components/SideBarCategoryElement.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import modalState from "@/features/shared/modal/services/modalState";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";

import {useTeamStore} from "@/stores/teamStore.js";
import {useRoleStore} from "@/stores/roleStore";
import {selectTeamAndFetchTeammates} from "@/features/captain/services/teamList.service";

import vector from "@/assets/images/Vector.png";
import plusIcon from "@/assets/images/plus.png";

const teamStore = useTeamStore();
const roleStore = useRoleStore();

//before mount, fetch teams, select first team from the saved list, get team name, fetch teammates.
onBeforeMount(async () => {
  await teamStore.setTeamListOfACaptain(roleStore.getCaptainsId);
  // automaticaly select first team right after team fetch, and save name

  if (teamStore.getTeamList.length > 0) {
    selectTeamAndFetchTeammates(teamStore.getTeamList[0].id);
  }
});

const onClickSelectTeam = (id: number) => {
  selectTeamAndFetchTeammates(id);
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
@/features/captain/services/teamList.service
