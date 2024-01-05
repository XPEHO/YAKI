import { MODALMODE } from "@/constants/modalMode.enum";
import { defineStore } from "pinia";
import { useTeamStore } from "@/stores/teamStore";
import { useTeammateStore } from "@/stores/teammateStore";
import { useRoleStore } from "@/stores/roleStore";
import { TeamType } from "@/models/team.type";

interface State {
  isShow: boolean;
  mode: MODALMODE;
  teamNameInputValue: string;
  teammateNameToDelete: string;
  teamDescriptionInputValue: string;
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
    getTeammateNameToDelete: (state: State) => state.teammateNameToDelete,
    getTeamDescriptionInputValue: (state: State) =>
      state.teamDescriptionInputValue,
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
    setTeammateNameToDelete(teammateName: string) {
      this.teammateNameToDelete = teammateName;
    },
    setTeamDescriptionInputValue(teamDescriptionInputValue: string) {
      this.teamDescriptionInputValue = teamDescriptionInputValue;
    },
    setCaptainNameToDelete(captainName: string) {
      this.captainNameToDelete = captainName;
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
      if (mode === MODALMODE.teamCreate || mode === MODALMODE.teamDelete) {
        this.setTeamNameInputValue("");
        this.setTeamDescriptionInputValue("");
      }

      if (setVisible === true && mode !== null) {
        this.setMode(mode!);
      }
      this.setIsShow(setVisible);
    },

    /**
     * Modal action management :
     * Invoked in ModalFrameView, when user click on "validation" button in modal
     * Trigger corresponding methods depending on the current modal mode set when invoking switchModalVisibility.
     * See MODALMODE enum for more information
     *
     * Actions :
     *
     * * teamCreate : create a team
     * * teamEdit : edit a team informations
     * * teamDelete : delete a team from the logged captain's team list
     * * userDelete : delete a user from a team
     */
    async onModalChoiceValidation(): Promise<void | TeamType> {
      switch (this.getMode) {
        case MODALMODE.teamCreate:
          return await this.handleTeamCreate();
        case MODALMODE.teamEdit:
          await this.handleTeamEdit();
          return;
        case MODALMODE.teamDelete:
          return await this.handleTeamDelete();
        case MODALMODE.userDelete:
          await this.handleUserDelete();
          return;
      }
    },
    /**
     * Create a team, and select it as the current team (setTeamSelected).
     * Reset the teammate list on teamateStore, as a new team do not come with teammates.
     * (it preventy to do an API call to fetch the teammate list)
     * Refresh the team list.
     * @return createdTeam: TeamType
     */
    async handleTeamCreate(): Promise<TeamType> {
      const teamStore = useTeamStore();
      const teammateStore = useTeammateStore();

      const createdTeam = await teamStore.createTeam(
        this.getTeamNameInputValue,
        this.getTeamDescriptionInputValue
      );
      teamStore.setTeamSelected(createdTeam);
      teammateStore.resetTeamatesList();
      await this.refreshTeamList();

      this.setTeamNameInputValue("");
      this.setTeamDescriptionInputValue("");
      return createdTeam;
    },
    /**
     * Edit the team name and the team description. Reset the input value afterwards.
     */
    async handleTeamEdit() {
      const teamStore = useTeamStore();

      const editedTeam = await teamStore.updateTeam(
        teamStore.getTeamSelected.id,
        teamStore.getTeamSelected.captainsId[0],
        this.getTeamNameInputValue,
        null,
        this.getTeamDescriptionInputValue,
      );

      teamStore.setTeamSelected(editedTeam);
      await this.refreshTeamList();
      this.setTeamNameInputValue("");
      this.setTeamDescriptionInputValue("");
    },
    /**
     * Delete the team.
     * Refresh the team list.
     * @return deletedTeam: TeamType
     */
    async handleTeamDelete(): Promise<TeamType> {
      const teamStore = useTeamStore();

      const deletedTeam = await teamStore.deleteTeam(
        teamStore.getTeamSelected.id
      );
      await this.refreshTeamList();

      return deletedTeam;
    },
    /**
     * Delete a user from a team.
     * Refresh the teammate list.
     */
    async handleUserDelete() {
      const teammateStore = useTeammateStore();
      await teammateStore.deleteTeammateFromTeam(
        teammateStore.getIdOfTeammateToDelete
      );
    },

    /**
     * Refetch the team list of a given captain.
     * Get all the captainsID from the roleStore the current connected user have.
     *
     * Invoked in modalStore handleTeamCreate / handleTeamEdit / handleTeamDelete
     */
    async refreshTeamList() {
      const teamStore = useTeamStore();
      const roleStore = useRoleStore();

      await teamStore.setTeamListOfACaptain(roleStore.getCaptainsId);
    },
  }, //actions end
});
