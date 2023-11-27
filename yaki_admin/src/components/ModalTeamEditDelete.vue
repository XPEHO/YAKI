<script setup lang="ts">
import SideBarMenuLink from "@/components/SideBarMenuLink.vue";
import pencilIcon from "@/assets/images/pencil-regular-24.png";
import deleteIcon from "@/assets/images/x_close.png";
import {MODALMODE} from "@/constants/modalMode";
import modalState from "@/features/modal/services/modalState";

const editTeam = () => {
  modalState.setTeamName(modalState.teamName);
  modalState.switchModalVisibility(true, MODALMODE.teamEdit);
};

const deleteTeam = () => {
  modalState.setTeamName(modalState.teamName);
  modalState.switchModalVisibility(true, MODALMODE.teamDelete);
};
</script>

<template>
  <section class="modal__container modal__edit-size">
    <side-bar-menu-link
      @click.prevent="editTeam"
      :text="'Edit team'"
      :icon="pencilIcon"
      :is-modal-element="true" />
    <side-bar-menu-link
      @click.prevent="deleteTeam"
      :text="'Delete team'"
      :icon="deleteIcon"
      :is-modal-element="true" />
  </section>
</template>
@/constants/modalMode @/constants/modalMode @/features/modal/services/modalState
