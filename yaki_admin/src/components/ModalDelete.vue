<script setup lang="ts">
import ButtonTextIcon from "@/components/ButtonTextIcon.vue";
import ButtonTextSized from "@/components/ButtonTextSized.vue";
import deleteIcon from "@/assets/images/x_close.png";
import {MODALMODE} from "@/constants/modalMode";
import {BUTTONCOLORS} from "@/constants/componentsSettings";
import {useModalStore} from "@/stores/modalStore";
import {useTeamStore} from "@/stores/teamStore";

const modalStore = useModalStore();
const teamStore = useTeamStore();

const defineTitle = () => {
  switch (modalStore.getMode) {
    case MODALMODE.userDelete:
      return "Remove user ?";
    case MODALMODE.teamDelete:
      return "Delete team ?";
  }
};

const validationModalAccept = async () => {
  modalStore.validationActions();

  modalStore.switchModalVisibility(false, null);
  return;
};

const cancelModalBtn = () => {
  modalStore.switchModalVisibility(false, null);
};
</script>

<template>
  <section class="modal__container modal__delete-size">
    <h1 class="modal__container-title">{{ defineTitle() }}</h1>

    <p
      v-if="modalStore.getMode === MODALMODE.userDelete"
      class="modal__container-text">
      Are you sure you want to remove <br />
      <span class="text__bold"> {{ modalStore.getTeammateNameToDelete }}</span>
      From :
      <span class="text__bold">{{ teamStore.getTeamSelected.teamName }}</span> ? <br />
      This action is irreversible !
    </p>

    <p
      v-else-if="modalStore.getMode === MODALMODE.teamDelete"
      class="modal__container-text">
      Are you sure you want to delete :
      <span class="text__bold"> {{ teamStore.getTeamSelected.teamName }}</span> ? <br />
      This action is irreversible !
    </p>

    <div class="modal__location-button">
      <button-text-sized
        text="Cancel"
        :color="BUTTONCOLORS.secondary"
        @click.prevent="cancelModalBtn" />
      <button-text-icon
        :text="modalStore.getMode === MODALMODE.userDelete ? 'REMOVE' : 'DELETE'"
        :icon="deleteIcon"
        :color="BUTTONCOLORS.delete"
        @click.prevent="validationModalAccept" />
    </div>
  </section>
</template>
