<script setup lang="ts">
import sideBarMenuDropDownElement from "./SideBarMenuDropDownElement.vue";
import groupIcon from "@/assets/images/group-regular-24.png";
import arrowIcon from "@/assets/images/chevron-down-regular-24.png";

import {useTeamStore} from "@/stores/teamStore";
import {useRoleStore} from "@/stores/roleStore";
import {onBeforeMount} from "vue";
import {selectTeamAndFetchTeammates} from "@/features/captain/services/teamList.service";
import router from "@/router/router";

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
  router.push({path: "/captain/manage-team"});
};

const props = defineProps({
  innerText: {
    type: String,
    required: true,
  },
  iconPath: {
    type: String,
    required: true,
  },
  isSelected: {
    type: Boolean,
    required: false,
    default: false,
  },
});
</script>

<template>
  <section class="drop-down__container">
    <div class="text-icon__container text-icon__container-height--padding text_icon--icon drop-down--sidebar-color">
      <figure>
        <img
          :src="groupIcon"
          alt="group icon" />
      </figure>
      <p class="text-icon--text">{{ props.innerText }}</p>
    </div>
    <input
      class="drop-down__checkbox"
      type="checkbox"
      id="sidebar-dropdown" />
    <figure class="drop-down__icon">
      <img
        :src="arrowIcon"
        alt="drop down menu arrow" />
    </figure>
    <section
      v-if="teamStore.getTeamList && teamStore.getTeamList.length > 0"
      class="drop-down__menu">
      <side-bar-menu-drop-down-element
        v-for="(team, index) in teamStore.getTeamList"
        :key="index"
        v-bind:id="team.id"
        v-bind:teamName="team.teamName"
        @click.prevent="() => onClickSelectTeam(team.id)" />
    </section>
    <section
      v-else
      class="drop-down__menu">
      <p class="no-teams">There is no team yet</p>
    </section>
  </section>
</template>

<style scoped lang="scss">
.no-teams {
  padding-inline-start: 16px;
  padding-block: 8px;
  color: rgb(238, 237, 237);
}
</style>
