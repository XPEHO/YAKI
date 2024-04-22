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

import { useI18n } from "vue-i18n";
const { t } = useI18n();
const translation = {
  remove: t("buttons.remove"),
  delete: t("buttons.delete"),
  userRemove: t("popups.teamRemoveUser.title"),
  captainRemove: t("popups.captainRemoval.title"),
  teamDelete: t("popups.teamDeletion.title"),
};

const title = computed(() => {
  switch (modalStore.getMode) {
    case MODALMODE.userDelete:
      return translation.userRemove;
    case MODALMODE.captainDelete:
      return translation.captainRemove;
    case MODALMODE.teamDelete:
      return translation.teamDelete;
  }
  return "";
});

const action = computed(() => {
  switch (modalStore.getMode) {
    case MODALMODE.userDelete:
      return translation.remove;
    case MODALMODE.captainDelete:
      return translation.remove;
    case MODALMODE.teamDelete:
      return translation.delete;
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
      {{ $t("popups.deletionConfirmation") }} {{ action.toLowerCase() }} <br />
      <span class="text__bold"> {{ deletedElement }} </span>
      <span
        v-if="
          modalStore.getMode === MODALMODE.userDelete ||
          modalStore.getMode === MODALMODE.captainDelete
        "
      >
        <span v-if="modalStore.getMode !== MODALMODE.captainDelete">
          {{ $t("popups.teamDeletion.from") }}
        </span>
        <span
          v-if="modalStore.getMode !== MODALMODE.captainDelete"
          class="text__bold"
          >{{ teamStore.getTeamSelected.teamName }}</span
        >
        ?
      </span>
      <br />
      {{ $t("popups.irreversible") }}
    </p>

    <div class="modal__location-button">
      <button-text-sized
        :text="$t('buttons.cancel')"
        :color="BUTTONCOLORS.secondary"
        @click.prevent="onCancelPress"
      />
      <button-text-icon
        :text="
          modalStore.getMode === MODALMODE.userDelete ? $t('buttons.remove') : $t('buttons.delete')
        "
        :icon="deleteIcon"
        :color="BUTTONCOLORS.delete"
        @click.prevent="onDeletePress"
      />
    </div>
  </section>
</template>
