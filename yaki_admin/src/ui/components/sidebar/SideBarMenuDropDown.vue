<script setup lang="ts">
import sideBarMenuDropDownElement from "./SideBarMenuDropDownElement.vue";
import groupIcon from "@/assets/icons_svg/Teams.svg";
import arrowIcon from "@/assets/icons_svg/Chevron-down.svg";
import addIcon from "@/assets/icons_svg/AddPlus.svg";

import router from "@/router/router";
import { useTeamStore } from "@/stores/teamStore";
import { useModalStore } from "@/stores/modalStore";
import { MODALMODE } from "@/constants/modalMode.enum";
import { TeamType } from "@/models/team.type";

const modalStore = useModalStore();
const teamStore = useTeamStore();

// add team button press to open modal
const onClickAddTeam = () => {
  modalStore.switchModalVisibility(true, MODALMODE.teamCreate);
};

const onClickSelectTeam = async (team: TeamType) => {
  await teamStore.setTeamSelectedAndFetchTeammates(team);
  router.push({ path: "/dashboard/manage-team" });
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
  isMenuOpen: {
    type: Boolean,
    required: true,
  },
});
</script>

<template>
  <section :class="['drop-down__container']">
    <div
      :class="[
        'text-icon__container',
        'text-icon__container-height--padding',
        'text_icon--icon',
        'drop-down--sidebar-color',
      ]"
    >
      <figure>
        <img
          :src="groupIcon"
          alt="group icon"
        />
      </figure>
      <p class="text-icon--text">{{ props.innerText }}</p>
    </div>

    <input
      class="drop-down__checkbox"
      type="checkbox"
      id="sidebar-dropdown"
      :checked="isMenuOpen"
    />

    <figure class="drop-down__icon image-filter">
      <img
        :src="arrowIcon"
        alt="drop down menu arrow"
      />
    </figure>

    <section class="drop-down__menu">
      <button
        @click.prevent="onClickAddTeam"
        class="drop-down__create-team"
      >
        <figure>
          <img
            :src="addIcon"
            alt="Add icon"
          />
        </figure>
        <p>{{ $t("sidebar.createTeam") }}</p>
      </button>

      <div
        v-if="teamStore.getTeamListByCaptain && teamStore.getTeamListByCaptain.length > 0"
        class="gap_add"
      >
        <side-bar-menu-drop-down-element
          v-for="team in teamStore.getTeamListByCaptain"
          :key="team.id"
          v-bind:id="team.id"
          v-bind:teamName="team.teamName"
          @click.prevent="() => onClickSelectTeam(team)"
        />
      </div>
      <div v-else>
        <p class="no-teams unselectabla-text">{{ $t("sidebar.noTeams") }}</p>
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
  font-family: Rubik, sans-serif;
  padding-inline-start: 16px;
  padding-block: 8px;
  color: rgb(238, 237, 237);
}

.drop-down__create-team {
  margin-block: 4px;
  padding-inline-start: 16px;
  min-height: 56px;

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
    font-family: Rubik, sans-serif;
    font-weight: 350;
    font-variant: normal;
    letter-spacing: 0.2px;

    color: black;
    font-size: 17px;
  }

  &:hover {
    background-color: #ff9169;
    cursor: pointer;

    figure {
      img {
        filter: invert(0.9);
      }
    }

    p {
      color: rgb(238, 237, 237);
    }
  }

  &:active {
    transform: scale(0.99) translateY(1px);
  }
}
</style>
