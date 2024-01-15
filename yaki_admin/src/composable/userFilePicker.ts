import { MODALMODE } from "@/constants/modalMode.enum";
import { setTeamLogoUrl } from "@/utils/images.utils";
import teamImage from "@/assets/images/teamDefaultImg2.svg";
import { ref } from "vue";
import { useTeamStore } from "@/stores/teamStore";

/**
 * Composition function handling the file picker.
 *
 * This function is responsible for handling the user's file input.
 *
 * @returns {Object} An object containing the following properties:
 * - logoSrc: ref holding the source URL of image. Initially set to a default image.
 * - isLogoToHeavy: ref indicating whether the selected file is too large (> 500KB), use in component to display a warning message.
 * - selectedFile: ref holding the selected File object.
 * - openFilePicker: A function that triggers the file input click event to open the file picker dialog.
 * - handleFileSelected: A function that handles the file input change event.
 * - setTeamLogo: A function that sets the team logo URL based on the current team selected logo.
 */
export function userFilePicker() {
  const teamStore = useTeamStore();

  // file handling

  const selectedFile = ref<File | null>(null);
  const logoSrc = ref(teamImage);
  const isLogoToHeavy = ref(false);

  const setTeamLogo = (newIsShow: boolean, newMode: MODALMODE) => {
    if (!newIsShow || (newMode !== MODALMODE.teamEdit && newMode !== MODALMODE.teamCreate)) {
      return;
    }
    const currentLogo = teamStore.getTeamSelectedLogo;

    logoSrc.value = setTeamLogoUrl(currentLogo.teamLogoBlob);
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
  const handleFileSelected = async (event: Event) => {
    const target = event.target as HTMLInputElement;

    if (target.files) {
      const file = target.files[0];
      selectedFile.value = file;

      if (file.size > 500000) {
        isLogoToHeavy.value = true;
        return;
      }

      // Object async read files (raw data or buffer)
      const reader = new FileReader();
      reader.onloadend = () => {
        // triggered when the read operation is finished, and apply the reader.result to the avatarSrc
        logoSrc.value = reader.result as string;
      };
      // read the blob or file content as a base64 encoded string
      reader.readAsDataURL(selectedFile.value);
    }
  };

  const setDefaultLogo = () => {
    logoSrc.value = teamImage;
  };

  return {
    logoSrc,
    isLogoToHeavy,
    selectedFile,
    handleFileSelected,
    setTeamLogo,
    setDefaultLogo,
  };
}
