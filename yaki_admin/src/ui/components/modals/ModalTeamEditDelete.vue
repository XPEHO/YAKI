<script setup lang="ts">
import SideBarMenuLink from "@/ui/components/sidebar/SideBarMenuLink.vue";
import pencilIcon from "@/assets/images/pencil-regular-24.png";
import deleteIcon from "@/assets/images/x_close.png";
import {MODALMODE} from "@/constants/modalMode";
import {useModalStore} from "@/stores/modalStore";

const modalStore = useModalStore();

const editTeam = () => {
  modalStore.switchModalVisibility(true, MODALMODE.teamEdit);
};

const deleteTeam = () => {
  modalStore.switchModalVisibility(true, MODALMODE.teamDelete);
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
