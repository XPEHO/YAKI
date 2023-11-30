<script setup lang="ts">
import sideBarMenuDropDownElement from "./SideBarMenuDropDownElement.vue";
import groupIcon from "@/assets/images/group-regular-24.png";
import arrowIcon from "@/assets/images/chevron-down-regular-24.png";
import addIcon from "@/assets/images/plus_icon.png";

import {useTeamStore} from "@/stores/teamStore";
import {onBeforeMount} from "vue";
import {MODALMODE} from "@/constants/modalMode";
import router from "@/router/router";
import {TeamType} from "@/models/team.type";
import {useModalStore} from "@/stores/modalStore";

const teamStore = useTeamStore();
const modalStore = useModalStore();

//before mount, fetch teams, select first team from the saved list, get team name, fetch teammates.
onBeforeMount(async () => {
  // automaticaly select first team right after team fetch on component mount ( right after the first connexion)
  if (teamStore.getTeamList && teamStore.getTeamList.length > 0) {
    teamStore.setTeamInfoAndFetchTeammates(teamStore.getTeamList[0]);
  }
});

// add team button press to open modal
const onClickAddTeam = () => {
  modalStore.switchModalVisibility(true, MODALMODE.teamCreate);
};

const onClickSelectTeam = (team: TeamType) => {
  teamStore.setTeamInfoAndFetchTeammates(team);
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
    <section class="drop-down__menu">
      <button
        @click.prevent="onClickAddTeam"
        class="drop-down__create-team">
        <figure>
          <img
            :src="addIcon"
            alt="Add icon" />
        </figure>
        <p>Create team</p>
      </button>
      <div
        v-if="teamStore.getTeamList && teamStore.getTeamList.length > 0"
        class="gap_add">
        <side-bar-menu-drop-down-element
          v-for="(team, index) in teamStore.getTeamList"
          :key="index"
          v-bind:id="team.id"
          v-bind:teamName="team.teamName"
          @click.prevent="() => onClickSelectTeam(team)" />
      </div>
      <div v-else>
        <p class="no-teams unselectabla-text">No team available</p>
      </div>
    </section>
  </section>
</template>

<style scoped lang="scss">
.gap_add {
  display: flex;
  flex-direction: column;
  gap: 5px;
}
.no-teams {
  padding-inline-start: 16px;
  padding-block: 8px;
  color: rgb(238, 237, 237);
}

.drop-down__create-team {
  margin-block: 4px;
  padding-inline-start: 16px;
  height: 56px;

  display: flex;
  align-items: center;
  gap: 8px;

  border: none;
  border-radius: 16px;
  background-color: transparent;

  figure {
    width: 24px;
    height: 24px;
    img {
      width: 100%;
      object-fit: contain;
    }
  }

  p {
    font-size: 17px;
    font-weight: 400;
  }

  &:hover {
    background-color: #ff9169;
    cursor: pointer;
    color: rgb(238, 237, 237);
    figure {
      img {
        filter: invert(0.9);
      }
    }
  }

  &:active {
    transform: scale(0.99) translateY(1px);
  }
}
</style>
