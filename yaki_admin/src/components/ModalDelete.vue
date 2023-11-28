<script setup lang="ts">
import ButtonTextIcon from "@/components/ButtonTextIcon.vue";
import ButtonTextSized from "@/components/ButtonTextSized.vue";
import deleteIcon from "@/assets/images/x_close.png";
import modalState from "@/features/modal/services/modalState";
import {MODALMODE} from "@/constants/modalMode";
import {BUTTONCOLORS} from "@/constants/componentsSettings";

const defineTitle = () => {
  switch (modalState.mode) {
    case MODALMODE.userDelete:
      return "Remove user ?";
    case MODALMODE.teamDelete:
      return "Delete team ?";
  }
};

const validationModalAccept = async () => {
  modalState.validationActions();

  modalState.switchModalVisibility(false, null);
  return;
};

const cancelModalBtn = () => {
  modalState.switchModalVisibility(false, null);
};
</script>

<template>
  <section class="modal__container modal__delete-size">
    <h1 class="modal__container-title">{{ defineTitle() }}</h1>

    <p
      v-if="modalState.mode === MODALMODE.userDelete"
      class="modal__container-text">
      Are you sure you want to remove
      <span class="text__bold"> {{ modalState.temmateName }}</span>
      From the team
      <span class="text__bold">{{ modalState.teamName }}</span> ? This action is irreversible !
    </p>

    <p
      v-if="modalState.mode === MODALMODE.teamDelete"
      class="modal__container-text">
      Are you sure you want to delete <span class="text__bold"> {{ modalState.temmateName }}</span> team ? This action
      is irreversible !
    </p>

    <div class="modal__location-button">
      <button-text-sized
        text="Cancel"
        :color="BUTTONCOLORS.secondary"
        @click.prevent="cancelModalBtn" />
      <button-text-icon
        :text="modalState.mode === MODALMODE.userDelete ? 'REMOVE' : 'DELETE'"
        :icon="deleteIcon"
        :color="BUTTONCOLORS.delete"
        @click.prevent="validationModalAccept" />
    </div>
  </section>
</template>
@/constants/modalMode @/constants/modalMode @/features/modal/services/modalState
