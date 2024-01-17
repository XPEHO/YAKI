<script setup lang="ts">
import ButtonIcon from "@/ui/components/buttons/ButtonIcon.vue";
import InputText from "@/ui/components/inputs/InputText.vue";
import InputTextArea from "@/ui/components/inputs/InputTextArea.vue";
import ButtonTextSized from "@/ui/components/buttons/ButtonTextSized.vue";

import pencilIcon from "@/assets/icons_svg/Edit.svg";
import deleteIcon from "@/assets/icons_svg/CrossClose.svg";
import defaultTeamImage from "@/assets/images/teamDefaultImg2.svg";

import { ref, watch } from "vue";

import { BUTTONCOLORS } from "@/constants/componentsSettings.enum";
import { MODALMODE } from "@/constants/modalMode.enum";
import { useModalStore } from "@/stores/modalStore";
import { userFilePicker } from "@/composable/userFilePicker";

const modalStore = useModalStore();
const isMissingTeamNameError = ref<boolean>(false);
const onOpenDisplayedLogo = ref("");

const {
  logoDisplayed,
  isFileSizeTooBig,
  inputFileElement,
  isLogoToBeDeleted,
  triggerFilePickerAndResetSizeFlag,
  handleSelectedFileAndValidation,
  setTeamLogoToDisplay,
  createOrDeleteLogo,
} = userFilePicker();

const modalText = ref({
  title: "",
  text: "",
});

/**
 * Depending on the modal mode, change the modal text
 * @param newIsShow modalStore.getIsShow
 * @param newMode modalStore.getMode
 */
const setCardText = (newIsShow: boolean, newMode: MODALMODE) => {
  if (newIsShow && newMode === MODALMODE.teamEdit) {
    modalText.value = {
      title: "Team edition",
      text: "You can edit your team name, description and logo",
    };
  } else if (newIsShow && newMode === MODALMODE.teamCreate) {
    modalText.value = {
      title: "Team creation",
      text: "The team name must be provided. You can also add a description and a logo",
    };
  }
};

// when the modal is shown and display this component.
watch(
  [() => modalStore.getMode, () => modalStore.getIsShow],
  ([newMode, newIsShow]) => {
    setTeamLogoToDisplay(newIsShow, newMode);
    setCardText(newIsShow, newMode);

    onOpenDisplayedLogo.value = logoDisplayed.value;
  },
  { immediate: true },
);

/**
 * Reset the state of :
 * * isMissingTeamNameError (error when user try to submit an empty team name)
 * * isFileSizeTooBig (error when user try to submit a logo that is too heavy)
 * * isLogoToBeDeleted (flag to delete the logo)
 */
const resetRef = () => {
  if (isMissingTeamNameError.value) isMissingTeamNameError.value = false;
  if (isFileSizeTooBig.value) isFileSizeTooBig.value = false;
  if (isLogoToBeDeleted.value) isLogoToBeDeleted.value = false;
};

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
  await createOrDeleteLogo();

  emit("onAccept");
  resetRef();
};

/**
 * Execute the cancel action (using emit to send the event to the ModalFrame parent component)
 */
const onCancelPress = () => {
  emit("onCancel");
  resetRef();
};

/**
 * On delete logo button press.
 * * On modal open :
 * * * Initial logo is an image, set the **delete flag** to true
 * * * Initial logo is the *default logo*, if a file was selected, set the *default logo* back
 * * * Initial logo is an image and a new image was selected, set the preview image back
 * * Reset the **delete flag** by pressing the button again.
 */
const deleteTeamLogo = () => {
  if (isLogoToBeDeleted.value) {
    isLogoToBeDeleted.value = false;
    return;
  }

  if (onOpenDisplayedLogo.value === defaultTeamImage) {
    // set back default logo
    logoDisplayed.value = defaultTeamImage;
  } else {
    if (onOpenDisplayedLogo.value !== logoDisplayed.value) {
      // set back preview image
      logoDisplayed.value = onOpenDisplayedLogo.value;
    } else {
      isLogoToBeDeleted.value = true;
    }
  }
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

/**
 * Register the input value in the modalStore.
 * @param value being emitted by the InputTextArea component
 */
const setTeamDescription = (value: string) => {
  modalStore.setTeamDescriptionInputValue(value);
};
</script>

<template>
  <section class="container__popup">
    <h1 class="container__title-text container__style">{{ modalText.title }}</h1>
    <p
      :class="['container__text', 'container__style', isFileSizeTooBig ? 'is_logo_too_heavy' : '']"
    >
      {{ modalText.text }}
    </p>

    <section class="popup__content">
      <section class="popup__avatar-section">
        <figure :class="[isLogoToBeDeleted ? 'logo_to_be_deleted logo_to_delete_filter' : '']">
          <img
            :src="logoDisplayed"
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
            @click="triggerFilePickerAndResetSizeFlag"
          />
          <input
            class="display_none"
            type="file"
            name="file"
            ref="inputFileElement"
            @change="handleSelectedFileAndValidation"
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
  content: "Your logo size is too big. Please select a logo under 500kb.";
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

.logo_to_be_deleted {
  position: relative;

  filter: grayscale(100%) brightness(0.7);

  &:after {
    content: "✕";
    position: absolute;

    font-size: 7rem;
    color: white;

    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);

    z-index: 1;

    filter: none;
  }
}
</style>
