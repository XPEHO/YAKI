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
import { useTeamLogoStore } from "@/stores/teamLogoStore";

const modalStore = useModalStore();
const inputFileElement = ref<HTMLElement | null>(null);
const isMissingTeamNameError = ref<boolean>(false);

const teamLogoStore = useTeamLogoStore();

// At modal open (in the watch), the logo displayed is the one that was saved in the store.
// its used to store the initial logo, and is used when the user want to edit the logo to still have the initial image
const onModalOpenLogo = ref("");

const modalText = ref({
  title: "",
  text: "",
});

/**
 * Reset on modal accept or cancel.
 * * isMissingTeamNameError (error when user try to submit an empty team name)
 * * isFileSizeTooBig (error when user try to submit a logo that is too heavy)
 *
 */
const teamNameAndFileSizeFlagReset = () => {
  if (isMissingTeamNameError.value) isMissingTeamNameError.value = false;
  if (teamLogoStore.isFileSizeTooBig) teamLogoStore.isFileSizeTooBig = false;
};

/**
 * On open picker and remove logo press.
 * Reset the size and delete flag to reset the visual effects on selecting new file.
 */
const sizeAndDeleteFlagReset = () => {
  if (teamLogoStore.getIsFileSizeTooBig) teamLogoStore.setIsFileSizeTooBig(false);
  if (teamLogoStore.getIsLogoToBeDeleted) teamLogoStore.setIsLogoToBeDeleted(false);
};

/**
 * Depending on the modal mode, change the modal text
 * @param newIsShow modalStore.getIsShow
 * @param newMode modalStore.getMode
 */
const setModalHeaderText = (newIsShow: boolean, newMode: MODALMODE) => {
  if (!newIsShow) return;

  if (newMode === MODALMODE.teamEdit) {
    modalText.value = {
      title: "Team edition",
      text: "You can edit your team name, description and logo",
    };
    return;
  }

  if (newMode === MODALMODE.teamCreate) {
    modalText.value = {
      title: "Team creation",
      text: "The team name must be provided. You can also add a description and a logo",
    };
    return;
  }
};

/**
 * On modal open.
 * (check if the newIsShow is true, and a modalModeMatch the current modal type).
 *  Set the initial logo to the one saved in the store.
 *  Set the modal header text.
 */
watch(
  [() => modalStore.getMode, () => modalStore.getIsShow],
  ([newMode, newIsShow]) => {
    teamLogoStore.setTeamLogoToDisplay(newIsShow, newMode);
    setModalHeaderText(newIsShow, newMode);

    onModalOpenLogo.value = teamLogoStore.getLogoDisplayed;
  },
  { immediate: true },
);

/**
 * Open the file picker and reset the file flag.
 * reset size and delete logo flags, to reset the visuals effect on selecting new file.
 */
const openFilePicker = () => {
  inputFileElement.value!.click();

  sizeAndDeleteFlagReset();
};

/**
 * On create logo button press.
 * * If the **delete flag** is true, reset it (as the user want to use another file as a logo)
 * Then trigger the function handling the selected file, and the validation. in order to display the new logo or not.
 * (the create or delete logo function will be called when the user will submit the form)
 */
const onAddLogoPress = () => {
  if (teamLogoStore.isLogoToBeDeleted) {
    teamLogoStore.setIsLogoToBeDeleted(false);
  }
  openFilePicker();
};

/**
 * On delete logo button press. IF :
 * * * Initial logo is an image, set the **delete flag** to true
 * * * Initial logo is the *default logo*, if a file was selected, set the *default logo* back
 * * * Initial logo is an image and a new image was selected, set the preview image back
 * * Reset the **delete flag** by pressing the button again.
 */
const onRemoveLogoPress = () => {
  // allow to toggle the delete flag so visual effect
  if (teamLogoStore.getIsLogoToBeDeleted) {
    sizeAndDeleteFlagReset();
    return;
  }

  const isDefaultLogo = onModalOpenLogo.value === defaultTeamImage;
  const isInitialLogoSameAsNewPickedLogo = onModalOpenLogo.value === teamLogoStore.getLogoDisplayed;

  if (isDefaultLogo) {
    teamLogoStore.setLogoDisplayed(defaultTeamImage);
  } else {
    isInitialLogoSameAsNewPickedLogo
      ? teamLogoStore.setIsLogoToBeDeleted(true)
      : teamLogoStore.setLogoDisplayed(onModalOpenLogo.value),
      teamLogoStore.setFileSelected(null);
  }
};

const emit = defineEmits(["onAccept", "onCancel"]);
/**
 * Check if the inputvalue saved in the modalStore is empty.
 * if it is, set the error to true to display the error message. Preventing the accept action to be executed.
 * If the input is not empty, execute the accept action (using emit to send the event to the ModalFrame parent component)
 */
const onModalAccept = async () => {
  if (modalStore.getTeamNameInputValue === "") {
    isMissingTeamNameError.value = true;
    return;
  }
  emit("onAccept");
  teamNameAndFileSizeFlagReset();
};

/**
 * Execute the cancel action (using emit to send the event to the ModalFrame parent component)
 */
const onModalCancel = () => {
  emit("onCancel");
  teamNameAndFileSizeFlagReset();
};

/**
 * Register the input value in the modalStore.
 * If the input is not empty and the error is true, set the error to false to remove the error message (the user is typing)
 * @param value being emitted by the InputText component
 */
const setTeamNameToDisplay = (value: string) => {
  if (value !== "" && isMissingTeamNameError.value === true) {
    isMissingTeamNameError.value = false;
  }
  modalStore.setTeamNameInputValue(value);
};

/**
 * Register the input value in the modalStore.
 * @param value being emitted by the InputTextArea component
 */
const setTeamDescriptionToDisplay = (value: string) => {
  modalStore.setTeamDescriptionInputValue(value);
};
</script>

<template>
  <section class="container__popup">
    <h1 class="container__title-text">{{ modalText.title }}</h1>
    <p class="container__text">
      {{ modalText.text }}
    </p>

    <section class="popup__content">
      <section class="popup__avatar-section">
        <figure
          :class="[
            teamLogoStore.isLogoToBeDeleted ? 'logo_to_be_deleted logo_to_delete_filter' : '',
          ]"
        >
          <div
            v-if="teamLogoStore.isFileSizeTooBig"
            class="is_logo_too_heavy"
          >
            <p>Your file is too large</p>
            <p>Please select a file</p>
            <p>under 500kb</p>
          </div>
          <img
            :class="[teamLogoStore.isFileSizeTooBig ? 'logo_too_heavy_gray_scale' : '']"
            :src="teamLogoStore.logoDisplayed"
            alt="avatar"
          />
        </figure>

        <aside class="container__buttons_aside">
          <button-icon
            :icon="deleteIcon"
            @click="onRemoveLogoPress"
          />
          <button-icon
            :icon="pencilIcon"
            @click="onAddLogoPress"
          />
          <input
            class="display_none"
            type="file"
            name="file"
            ref="inputFileElement"
            @change="teamLogoStore.validateAndProcessFile"
          />
        </aside>
      </section>

      <form class="popup__input-container">
        <input-text
          label-text="Team name"
          :inputValue="modalStore.getTeamNameInputValue"
          @emittedInput="setTeamNameToDisplay"
          :isError="isMissingTeamNameError"
        />

        <input-text-area
          label-text="'Team description'"
          :inputValue="modalStore.getTeamDescriptionInputValue"
          @emittedInput="setTeamDescriptionToDisplay"
        />

        <section class="container__buttons_form">
          <button-text-sized
            text="Cancel"
            :color="BUTTONCOLORS.secondary"
            @click.prevent="onModalCancel"
            type="button"
          />
          <button-text-sized
            text="Modify"
            :color="BUTTONCOLORS.primary"
            @click.prevent="onModalAccept"
            type="submit"
          />
        </section>
      </form>
    </section>
  </section>
</template>

<style scoped lang="scss">
.is_logo_too_heavy {
  z-index: 1;
  font-family: $font-sf-compact;

  position: absolute;
  top: 41%;
  left: 6%;
  font-size: 0.9rem;
  font-weight: 900;
  color: rgb(228, 62, 62);

  display: flex;
  flex-direction: column;
  align-items: center;
}

.logo_too_heavy_gray_scale {
  filter: grayscale(100%) brightness(0.3);
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
