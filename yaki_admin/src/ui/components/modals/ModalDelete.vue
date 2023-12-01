<script setup lang="ts">
import ButtonTextIcon from "@/ui/views/components/buttons/ButtonTextIcon.vue";
import ButtonTextSized from "@/ui/views/components/buttons/ButtonTextSized.vue";
import deleteIcon from "@/assets/images/x_close.png";

import {BUTTONCOLORS} from "@/constants/componentsSettings";
import {MODALMODE} from "@/constants/modalMode";

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

const emit = defineEmits(["onAccept", "onCancel"]);

const onCancelPress = () => {
  emit("onCancel");
};

const onDeletePress = async () => {
  emit("onAccept");
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
        @click.prevent="onCancelPress" />
      <button-text-icon
        :text="modalStore.getMode === MODALMODE.userDelete ? 'REMOVE' : 'DELETE'"
        :icon="deleteIcon"
        :color="BUTTONCOLORS.delete"
        @click.prevent="onDeletePress" />
    </div>
  </section>
</template>
