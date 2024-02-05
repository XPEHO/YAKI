<script setup lang="ts">
import ButtonTextIcon from "@/ui/components/buttons/ButtonTextIcon.vue";
import ButtonTextSized from "@/ui/components/buttons/ButtonTextSized.vue";
import deleteIcon from "@/assets/icons_svg/CrossClose.svg";

import { BUTTONCOLORS } from "@/constants/componentsSettings.enum";
import { MODALMODE } from "@/constants/modalMode.enum";

import { useModalStore } from "@/stores/modalStore";
import { useTeamStore } from "@/stores/teamStore";
import { computed } from "vue";

const modalStore = useModalStore();
const teamStore = useTeamStore();

const title = computed(() => {
  switch (modalStore.getMode) {
    case MODALMODE.userDelete:
      return "Remove user ?";
    case MODALMODE.captainDelete:
      return "Remove captain ?";
    case MODALMODE.teamDelete:
      return "Delete team ?";
  }
  return "";
});

const action = computed(() => {
  switch (modalStore.getMode) {
    case MODALMODE.userDelete:
      return "Remove";
    case MODALMODE.captainDelete:
      return "Remove";
    case MODALMODE.teamDelete:
      return "Delete";
  }
  return "";
});

const deletedElement = computed(() => {
  switch (modalStore.getMode) {
    case MODALMODE.userDelete:
      return modalStore.getTeammateNameToDelete;
    case MODALMODE.captainDelete:
      return modalStore.getCaptainNameToDelete;
    case MODALMODE.teamDelete:
      return teamStore.getTeamSelected.teamName;
  }
  return "";
});

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
    <h1 class="modal__container-title">{{ title }}</h1>

    <p class="modal__container-text">
      Are you sure you want to {{ action }} <br />
      <span class="text__bold"> {{ deletedElement }} </span>
      <span
        v-if="
          modalStore.getMode === MODALMODE.userDelete ||
          modalStore.getMode === MODALMODE.captainDelete
        "
      >
        <span v-if="modalStore.getMode !== MODALMODE.captainDelete"> From : </span>
        <span
          v-if="modalStore.getMode !== MODALMODE.captainDelete"
          class="text__bold"
          >{{ teamStore.getTeamSelected.teamName }}</span
        >
        ?
      </span>
      <br />
      This action is irreversible !
    </p>

    <div class="modal__location-button">
      <button-text-sized
        text="Cancel"
        :color="BUTTONCOLORS.secondary"
        @click.prevent="onCancelPress"
      />
      <button-text-icon
        :text="modalStore.getMode === MODALMODE.userDelete ? 'REMOVE' : 'DELETE'"
        :icon="deleteIcon"
        :color="BUTTONCOLORS.delete"
        @click.prevent="onDeletePress"
      />
    </div>
  </section>
</template>
