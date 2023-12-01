<script setup lang="ts">
import ButtonIcon from "@/ui/components/buttons/ButtonIcon.vue";
import InputText from "@/ui/components/inputs/InputText.vue";
import InputTextArea from "@/ui/components/inputs/InputTextArea.vue";
import ButtonTextSized from "@/ui/components/buttons/ButtonTextSized.vue";

import pencilIcon from "@/assets/images/pencil-regular-24.png";
import deleteIcon from "@/assets/images/x_close.png";

import {BUTTONCOLORS} from "@/constants/componentsSettings";
import {useModalStore} from "@/stores/modalStore";
import {ref} from "vue";

const modalStore = useModalStore();
const isMissingTeamNameError = ref(false);

const emit = defineEmits(["onAccept", "onCancel"]);

const onCancelPress = () => {
  emit("onCancel");
  isMissingTeamNameError.value = false;
};

/**
 * Check if the inputvalue saved in the modalStore is empty.
 * if it is, set the error to true to display the error message. Preventing the accept action to be executed.
 * If the input is not empty, execute the accept action (using emit to send the event to the ModalFrame parent component)
 */
const onAcceptPress = async () => {
  if (modalStore.getTeamNameInputValue === "") {
    isMissingTeamNameError.value = true;
    return;
  }
  emit("onAccept");
};

/**
 * Register the input value in the modalStore.
 * If the input is not empty and the error is true, set the error to false to remove the error message (the user is typing)
 * @param value being emitted by the InputText component
 */
const setTeamName = (value: any) => {
  if (value !== "" && isMissingTeamNameError.value === true) {
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
            @emittedInput="setTeamName" />

          <input-text-area
            label-text="'Team description'"
            :inputValue="''"
            @emittedInput="setTeamDescription" />
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
