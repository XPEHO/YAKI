<script setup lang="ts">
import ButtonIcon from "@/ui/components/buttons/ButtonIcon.vue";
import InputText from "@/ui/components/inputs/InputText.vue";
import InputTextArea from "@/ui/components/inputs/InputTextArea.vue";
import ButtonTextSized from "@/ui/components/buttons/ButtonTextSized.vue";

import pencilIcon from "@/assets/icons_svg/Edit.svg";
import deleteIcon from "@/assets/icons_svg/CrossClose.svg";

import { BUTTONCOLORS } from "@/constants/componentsSettings.enum";
import { useModalStore } from "@/stores/modalStore";
import { useTeamStore } from "@/stores/teamStore";
import { ref, watch } from "vue";

import { MODALMODE } from "@/constants/modalMode.enum";

import { userFilePicker } from "@/composable/userFilePicker";

const modalStore = useModalStore();
const teamStore = useTeamStore();
const isMissingTeamNameError = ref(false);
const fileInput = ref<HTMLElement | null>(null);

const { logoSrc, isLogoToHeavy, selectedFile, handleFileSelected, setTeamLogo, setDefaultLogo } =
  userFilePicker();

const modalText = ref({
  title: "",
  text: "",
});

const teamEdition = {
  title: "Team edition",
  text: "You can edit your team name, description and logo",
};

const teamCreation = {
  title: "Team creation",
  text: "The team name must be provided. You can also add a description and a logo",
};

const setCardText = (newIsShow: boolean, newMode: MODALMODE) => {
  if (newIsShow && newMode === MODALMODE.teamEdit) {
    modalText.value = teamEdition;
  } else if (newIsShow && newMode === MODALMODE.teamCreate) {
    modalText.value = teamCreation;
  }
};

watch(
  [() => modalStore.getMode, () => modalStore.getIsShow],
  ([newMode, newIsShow]) => {
    setTeamLogo(newIsShow, newMode);
    setCardText(newIsShow, newMode);
  },
  { immediate: true },
);

const emit = defineEmits(["onAccept", "onCancel"]);

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

  if (selectedFile.value) {
    await teamStore.createOrUpdateTeamLogo(selectedFile.value);
    selectedFile.value = null;
  }

  emit("onAccept");
};

/**
 * Register the input value in the modalStore.
 * If the input is not empty and the error is true, set the error to false to remove the error message (the user is typing)
 * @param value being emitted by the InputText component
 */
const setTeamName = (value: string) => {
  if (value !== "" && isMissingTeamNameError.value === true) {
    isMissingTeamNameError.value = false;
  }
  modalStore.setTeamNameInputValue(value);
};

const setTeamDescription = (value: string) => {
  modalStore.setTeamDescriptionInputValue(value);
};

/**
 * Execute the cancel action (using emit to send the event to the ModalFrame parent component)
 */
const onCancelPress = () => {
  if (isMissingTeamNameError.value) isMissingTeamNameError.value = false;
  if (isLogoToHeavy.value) isLogoToHeavy.value = false;
  emit("onCancel");
};

/**
 * Trigger the file input click event to open the file picker dialog.
 */
const openFilePicker = () => {
  fileInput.value!.click();

  if (isLogoToHeavy.value) isLogoToHeavy.value = false;
};

const deleteTeamLogo = () => {
  setDefaultLogo();
};
</script>

<template>
  <section class="container__popup">
    <h1 class="container__title-text container__style">{{ modalText.title }}</h1>
    <p :class="['container__text', 'container__style', isLogoToHeavy ? 'is_logo_too_heavy' : '']">
      {{ modalText.text }}
    </p>

    <section class="popup__content">
      <section class="popup__avatar-section">
        <figure>
          <img
            :src="logoSrc"
            alt="avatar"
          />
        </figure>

        <aside class="container__buttons">
          <button-icon
            :icon="deleteIcon"
            @click="deleteTeamLogo"
          />
          <button-icon
            :icon="pencilIcon"
            @click="openFilePicker"
          />
          <input
            class="display_none"
            type="file"
            name="file"
            ref="fileInput"
            @change="handleFileSelected"
          />
        </aside>
      </section>

      <section class="popup__content">
        <form class="popup__input-container">
          <input-text
            label-text="Team name"
            :inputValue="modalStore.getTeamNameInputValue"
            @emittedInput="setTeamName"
            :isError="isMissingTeamNameError"
          />

          <input-text-area
            label-text="'Team description'"
            :inputValue="modalStore.getTeamDescriptionInputValue"
            @emittedInput="setTeamDescription"
          />

          <section class="container__buttons--popup">
            <button-text-sized
              text="Cancel"
              :color="BUTTONCOLORS.secondary"
              @click.prevent="onCancelPress"
              type="button"
            />
            <button-text-sized
              text="Modify"
              :color="BUTTONCOLORS.primary"
              @click.prevent="onAcceptPress"
              type="submit"
            />
          </section>
        </form>
      </section>
    </section>
  </section>
</template>

<style scoped lang="scss">
.is_logo_too_heavy:after {
  font-family: $font-sf-compact;
  content: "Your logo is too heavy. Please select a logo under 500kb.";
  position: absolute;
  top: 26.5%;
  left: 50px;
  font-size: 0.8rem;
  font-weight: 400;
  color: red;
}

.display_none {
  display: none;
}
</style>
