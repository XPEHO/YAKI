import { MODALMODE } from "@/constants/modalMode.enum";
import { setTeamLogoUrl } from "@/utils/images.utils";
import defaultTeamImage from "@/assets/images/teamDefaultImg2.svg";
import { ref } from "vue";
import { useTeamStore } from "@/stores/teamStore";

/**
 * Composition function handling the file picker.
 *
 * This function is responsible for handling the user's file input.
 *
 * @returns {Object} An object containing the following properties:
 * - logoDisplayed: ref holding the source URL of the logo image used to be displayed in a img src. Initially set to a default image.
 * - isFileSizeTooBig: ref indicating whether the selected file is too large (> 500KB). Used in component to display a warning message.
 * - inputFileElement: ref holding the input file HTML element (vue3 alternative to querySelector).
 * - isLogoToBeDeleted: ref indicating whether option to delete the logo is selected.
 * - triggerFilePickerAndResetSizeFlag: Function : Triggers the file input click to open the file picker dialog and resets the file size flag.
 * - handleSelectedFileAndValidation: Function : Handles the file input change event, validates the selected file, and updates the logoDisplayed ref to preview the selected image
 * - setTeamLogoToDisplay: Function : Sets the logoDisplayed ref based on if the modal is displayed and mode.
 * - setDefaultLogo: Function : Sets the logoDisplayed ref to the default team image.
 * - createOrDeleteLogo: Function : Deletes the team logo or creates/updates it based on the isLogoToBeDeleted and fileSelected refs.
 */
export function userFilePicker() {
  const teamStore = useTeamStore();

  const inputFileElement = ref<HTMLElement | null>(null);
  const fileSelected = ref<File | null>(null);
  const isFileSizeTooBig = ref<boolean>(false);
  const fileSizeLimit: number = 500000; // 500KB

  const logoDisplayed = ref(defaultTeamImage);
  const isLogoToBeDeleted = ref<boolean>(false);

  /**
   * Trigger the file input click event to open the file picker dialog.
   */
  const triggerFilePickerAndResetSizeFlag = () => {
    inputFileElement.value!.click();
    if (isFileSizeTooBig.value) isFileSizeTooBig.value = false;
  };

  /**
   * Handle the file input change event.
   *
   * Is triggered when a file is selected in the file input element.
   * Checks if any file has been selected.
   * Then, it checks for a size limit. If it goes over the limit set `isLogoToHeavy` to true and returns.
   * Else creates a new FileReader object to read the file content and assigne it to the selecteFile ref used to display the image.
   *
   * @param event - The event object associated with the file input change event.
   * @returns void
   */
  const handleSelectedFileAndValidation = async (event: Event) => {
    const target = event.target as HTMLInputElement;

    // if no file selected, return
    if (!target.files) return;

    const file = target.files[0];
    fileSelected.value = file;

    // Check if the file is an image or a gif
    if (!file.type.startsWith("image/")) {
      // Handle non-image file...
      console.error("File is not an image");
      return;
    }

    if (file.size > fileSizeLimit) {
      isFileSizeTooBig.value = true;
      // reset the fileSelected.value to null to prevent the logo creation
      fileSelected.value = null;
      return;
    }

    // reset logo deletion effect on newselected file
    if (isLogoToBeDeleted.value) isLogoToBeDeleted.value = false;

    // Object async read files (raw data or buffer)
    const reader = new FileReader();
    reader.onloadend = () => {
      // triggered when the read operation is finished, and apply the reader.result to the avatarSrc
      logoDisplayed.value = reader.result as string;
    };
    // read the blob or file content as a base64 encoded string
    reader.readAsDataURL(fileSelected.value);
  };

  /**
   * Triggered in ModalCreateEdit in watch (modalStore.isShow or modalStore.mode)
   * if the modal is show and the mode is teamEdit or teamCreate, retrive the current team logo.
   * And set it to the logoSrc, ref used to display the logo image.
   * @param newIsShow modalStore is show value
   * @param newMode  modalStore mode value
   * @returns
   */
  const setTeamLogoToDisplay = (newIsShow: boolean, newMode: MODALMODE) => {
    if (!newIsShow || (newMode !== MODALMODE.teamEdit && newMode !== MODALMODE.teamCreate)) {
      return;
    }
    const currentLogo = teamStore.getTeamSelectedLogo;

    logoDisplayed.value = setTeamLogoUrl(currentLogo.teamLogoBlob);
  };

  /**
   * Create or delete the team logo.
   * Based on the isLogoToBeDeleted and fileSelected refs.
   */
  const createOrDeleteLogo = async () => {
    // if logo is to be deleted, delete it
    if (isLogoToBeDeleted.value) {
      await teamStore.deleteTeamLogo();

      // set back default logo
      logoDisplayed.value = defaultTeamImage;
    }

    // if logo is not to be deleted and a file is selected, create or update the logo
    if (!isLogoToBeDeleted.value && fileSelected.value) {
      await teamStore.createOrUpdateTeamLogo(fileSelected.value);
      fileSelected.value = null;
    }
  };

  return {
    logoDisplayed,
    isFileSizeTooBig,
    inputFileElement,
    isLogoToBeDeleted,
    triggerFilePickerAndResetSizeFlag,
    handleSelectedFileAndValidation,
    setTeamLogoToDisplay,
    createOrDeleteLogo,
  };
}
