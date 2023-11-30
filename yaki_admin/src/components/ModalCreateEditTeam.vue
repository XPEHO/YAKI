<script setup lang="ts">
import ButtonIcon from "@/components/ButtonIcon.vue";
import InputText from "@/components/InputText.vue";
import InputTextArea from "@/components/InputTextArea.vue";
import ButtonTextSized from "./ButtonTextSized.vue";

import pencilIcon from "@/assets/images/pencil-regular-24.png";
import deleteIcon from "@/assets/images/x_close.png";

import {BUTTONCOLORS} from "@/constants/componentsSettings";
import {useModalStore} from "@/stores/modalStore";
import {isATeamType} from "@/models/team.type";
import {MODALMODE} from "@/constants/modalMode";
import router from "@/router/router";
import {TEAMPARAMS} from "@/constants/pathParam";
import {ref} from "vue";

const modalStore = useModalStore();
const isMissingTeamNameError = ref(false);

const onCancelPress = () => {
  modalStore.switchModalVisibility(false, null);
  isMissingTeamNameError.value = false;
};

const onAcceptPress = async () => {
  if (modalStore.getTeamNameInputValue === "") {
    isMissingTeamNameError.value = true;
    return;
  }

  const result = await modalStore.validationActions();
  modalStore.switchModalVisibility(false, null);

  const currentPath = router.currentRoute.value.path;
  if (modalStore.getMode === MODALMODE.teamCreate && isATeamType(result)) {
    if (currentPath === `/captain/team/${TEAMPARAMS.empty}` || currentPath === `/captain/team/${TEAMPARAMS.deleted}`) {
      router.push({path: "/captain/manage-team"});
    }
  }
};

const setTeamName = (value: any) => {
  if (value !== "") {
    isMissingTeamNameError.value = false;
  }
  modalStore.setTeamNameInputValue(value);
};

const setTeamDescription = (value: any) => {};
</script>

<template>
  <section class="container__popup">
    <h1 class="container__title-text container__style">Titre</h1>
    <p class="container__text container__style">Texte</p>

    <section class="popup__content">
      <section class="popup__avatar-section">
        <figure>
          <img
            src="../assets/images/avatar_2.png"
            alt="avatar" />
        </figure>

        <aside class="container__buttons">
          <button-icon :icon="deleteIcon" />
          <button-icon :icon="pencilIcon" />
        </aside>
      </section>

      <section class="popup__content">
        <form class="popup__input-container">
          <input-text
            label-text="Team name"
            :inputValue="modalStore.getTeamNameInputValue"
            :isError="isMissingTeamNameError"
            @inputValue="setTeamName" />

          <input-text-area
            label-text="'Team description'"
            :inputValue="''"
            @inputValue="setTeamDescription" />
          <section class="container__buttons--popup">
            <button-text-sized
              text="Cancel"
              :color="BUTTONCOLORS.secondary"
              @click.prevent="onCancelPress"
              type="button" />
            <button-text-sized
              text="Modify"
              :color="BUTTONCOLORS.primary"
              @click.prevent="onAcceptPress"
              type="submit" />
          </section>
        </form>
      </section>
    </section>
  </section>
</template>
