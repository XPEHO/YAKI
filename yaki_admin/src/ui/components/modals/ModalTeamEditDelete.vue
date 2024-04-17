<script setup lang="ts">
import SideBarMenuLink from "@/ui/components/sidebar/SideBarMenuLink.vue";
import pencilIcon from "@/assets/icons_svg/Edit.svg";
import deleteIcon from "@/assets/icons_svg/CrossClose.svg";
import { MODALMODE } from "@/constants/modalMode.enum";
import { useModalStore } from "@/stores/modalStore";

// allow to trigger the event on the parent component
// and close the modal once a choice has been made
// see content header view
const emit = defineEmits(["onChoiceSelection"]);

const modalStore = useModalStore();

const editTeam = () => {
  modalStore.switchModalVisibility(true, MODALMODE.teamEdit);
  emit("onChoiceSelection");
};

const deleteTeam = () => {
  modalStore.switchModalVisibility(true, MODALMODE.teamDelete);
  emit("onChoiceSelection");
};
</script>

<template>
  <section class="modal__container modal__edit-size">
    <side-bar-menu-link
      @click.prevent="editTeam"
      :text="$t('buttons.editTeam')"
      :icon="pencilIcon"
      :is-modal-element="true"
    />
    <side-bar-menu-link
      @click.prevent="deleteTeam"
      :text="$t('buttons.deleteTeam')"
      :icon="deleteIcon"
      :is-modal-element="true"
    />
  </section>
</template>
