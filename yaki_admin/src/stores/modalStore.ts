import { MODALMODE } from "@/constants/modalMode.enum";
import { defineStore } from "pinia";
import { useTeamStore } from "@/stores/teamStore";

interface State {
  isShow: boolean;
  mode: MODALMODE;
  teamNameInputValue: string;
  teamDescriptionInputValue: string;
  teammateNameToDelete: string;
  captainNameToDelete: string;
}

export const useModalStore = defineStore("userModalStore", {
  state: () => ({
    isShow: false as boolean,
    mode: "" as MODALMODE,
    teamNameInputValue: "" as string,
    teammateNameToDelete: "" as string,
    teamDescriptionInputValue: "" as string,
    captainNameToDelete: "" as string,
  }),

  getters: {
    getIsShow: (state: State) => state.isShow,
    getMode: (state: State) => state.mode,
    getTeamNameInputValue: (state: State) => state.teamNameInputValue,
    getTeamDescriptionInputValue: (state: State) => state.teamDescriptionInputValue,
    getTeammateNameToDelete: (state: State) => state.teammateNameToDelete,
    getCaptainNameToDelete: (state: State) => state.captainNameToDelete,
  },

  actions: {
    setIsShow(isShow: boolean) {
      this.isShow = isShow;
    },
    setMode(mode: MODALMODE) {
      this.mode = mode;
    },
    setTeamNameInputValue(teamNameInputValue: string) {
      this.teamNameInputValue = teamNameInputValue;
    },
    setTeamDescriptionInputValue(teamDescriptionInputValue: string) {
      this.teamDescriptionInputValue = teamDescriptionInputValue;
    },
    setTeammateNameToDelete(teammateName: string) {
      this.teammateNameToDelete = teammateName;
    },
    setCaptainNameToDelete(captainName: string) {
      this.captainNameToDelete = captainName;
    },
    /**
     * Reset modal visibility and mode.s
     */
    resetStates() {
      this.setIsShow(false);
      this.mode = "" as MODALMODE;
      this.setTeamNameInputValue("");
      this.setTeamDescriptionInputValue("");
      this.setTeammateNameToDelete("");
    },

    /**
     * Determine modal visibility :
     *
     * If true, must set modal mode, MODALMODE enum must be used.
     * Set null if modal is going to be hidden
     * @param setVisible : boolean to display or not the modal
     * @param mode : MODALMODE to change modal content | null if modal is going to be hidden, this is not changing the previewsly set mode
     * @param teamName : Optionnal parameter, set teamName for edit name purpose, else ignore.
     */
    switchModalVisibility(setVisible: boolean, mode: MODALMODE | null) {
      const teamStore = useTeamStore();
      const { teamName, teamDescription } = teamStore.getTeamSelected;

      // get current teamName and teamDescription and set it as input value for edition
      if (mode === MODALMODE.teamEdit && teamName) {
        this.setTeamNameInputValue(teamName);
        if (teamDescription) {
          this.setTeamDescriptionInputValue(teamDescription);
        }
      }

      if (mode === MODALMODE.teamCreate) {
        teamStore.resetTeamStoreSelectedLogo();
      }

      if (mode === MODALMODE.teamCreate || mode === MODALMODE.teamDelete) {
        this.setTeamNameInputValue("");
        this.setTeamDescriptionInputValue("");
      }

      if (setVisible === true && mode !== null) {
        this.setMode(mode);
      }
      this.setIsShow(setVisible);
    },
  },
});
