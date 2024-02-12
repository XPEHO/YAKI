import { MODALMODE } from "@/constants/modalMode.enum";
import { setTeamLogoUrl } from "@/utils/images.utils";
import { defineStore } from "pinia";
import { useTeamStore } from "@/stores/teamStore";
import { teamLogoService } from "@/services/teamLogo.service";
import { TeamLogoType } from "@/models/TeamLogo.type";

interface State {
  fileSelected: File | null;
  logoDisplayed: string;
  isFileSizeTooBig: boolean;
  isLogoToBeDeleted: boolean;
  fileSizeLimit: number;
}

export const useTeamLogoStore = defineStore("teamLogoStore", {
  state: () => ({
    fileSelected: null as File | null,
    logoDisplayed: "",
    isFileSizeTooBig: false,
    isLogoToBeDeleted: false,
    fileSizeLimit: 500000, // 500KB
  }),
  getters: {
    getFileSelected: (state: State) => state.fileSelected,
    getLogoDisplayed: (state: State) => state.logoDisplayed,
    getIsFileSizeTooBig: (state: State) => state.isFileSizeTooBig,
    getIsLogoToBeDeleted: (state: State) => state.isLogoToBeDeleted,
  },
  actions: {
    setFileSelected(file: File | null): void {
      this.fileSelected = file;
    },
    setLogoDisplayed(logo: string): void {
      this.logoDisplayed = logo;
    },
    setIsFileSizeTooBig(isFileSizeTooBig: boolean): void {
      this.isFileSizeTooBig = isFileSizeTooBig;
    },
    setIsLogoToBeDeleted(isLogoToBeDeleted: boolean): void {
      this.isLogoToBeDeleted = isLogoToBeDeleted;
    },
    setFileSizeLimit(fileSizeLimit: number): void {
      this.fileSizeLimit = fileSizeLimit;
    },

    /**
     * invoked in ModalCreateEdit watch  (modalStore.isShow or modalStore.mode)
     * * if the modal is show and the mode is teamEdit or teamCreate, retrive the current team logo
     * (early return allow to check if condition are not meet).
     * * And set it to the logoSrc, ref used to display the logo image.
     * @param newIsShow modalStore is show value
     * @param newMode  modalStore mode value
     * @returns
     */
    setTeamLogoToDisplay(isShow: boolean, modalMode: MODALMODE): void {
      const teamStore = useTeamStore();

      if (!isShow || (modalMode !== MODALMODE.teamEdit && modalMode !== MODALMODE.teamCreate)) {
        return;
      }
      const currentLogo = teamStore.getTeamSelectedLogo.teamLogoBlob;
      this.logoDisplayed = setTeamLogoUrl(currentLogo);
    },

    /**
     * Checks if the selected file is an image, if its not return false.
     * else return true.
     * @param file
     * @returns boolean
     */
    isImageFile(file: File): boolean {
      if (!file.type.startsWith("image/")) {
        console.error("File is not an image");
        return false;
      }
      return true;
    },

    /**
     * Checks for a size limit. If it goes over the limit set `isLogoToHeavy`
     * @param file
     * @returns boolan
     */
    isTooBigFile(file: File): boolean {
      if (file.size > this.fileSizeLimit) {
        this.setIsFileSizeTooBig(true);
        return true;
      }
      return false;
    },

    /**
     * Invoked on file input change event.
     *
     * Checks if any file has been selected.
     * Then, it checks for a size limit. If it goes over the limit set `isLogoToHeavy` to true and returns.
     * Else creates a new FileReader object to read the file content and assigne it to the selecteFile ref used to display the image.
     *
     * @param event - The event object associated with the file input change event.
     * @returns void
     */
    validateAndProcessFile(event: Event): void {
      const target = event.target as HTMLInputElement;

      // if no file selected, return
      if (!target.files) return;

      const file = target.files[0];
      if (!this.isImageFile(file) || this.isTooBigFile(file)) {
        return;
      }
      this.setFileSelected(file);

      // Object async read files (raw data or buffer)
      const reader = new FileReader();
      reader.onloadend = () => {
        // triggered when the read operation is finished, and apply the reader.result to the avatarSrc
        this.setLogoDisplayed(reader.result as string);
      };
      // read the blob or file content as a base64 encoded string
      if (this.getFileSelected) reader.readAsDataURL(this.getFileSelected);
    },

    /**
     * Create or update the team logo.
     * The selected file is reset to null after the operation.
     */
    async createOrUpdate(): Promise<void> {
      const teamStore = useTeamStore();

      if (!this.fileSelected) return;

      const savedTeamLogo: TeamLogoType = await teamLogoService.createOrUpdateTeamLogo(
        teamStore.getTeamSelected.id,
        this.fileSelected,
      );

      if (savedTeamLogo.teamLogoBlob === null) return;
      teamStore.teamSelectedLogo = savedTeamLogo;
      this.setFileSelected(null);
    },

    /**
     * delete the team logo.
     * The selected file is reset to null after the operation.
     * The isLogoToBeDeleted is reset to remove the visual effect
     * (will not be visible when the modal is once again open).
     */
    async delete(): Promise<Promise<void>> {
      const teamStore = useTeamStore();

      teamLogoService.deleteTeamLogo(teamStore.getTeamSelected.id);
      teamStore.resetTeamStoreSelectedLogo();

      this.setFileSelected(null);
      this.setIsLogoToBeDeleted(false);
    },
  },
});
