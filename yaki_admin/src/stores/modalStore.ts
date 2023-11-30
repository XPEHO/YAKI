import {MODALMODE} from "@/constants/modalMode";
import {defineStore} from "pinia";
import {useTeamStore} from "@/stores/teamStore";
import {useTeammateStore} from "@/stores/teammateStore";
import {useRoleStore} from "@/stores/roleStore";
import {TeamType} from "@/models/team.type";

interface State {
  isShow: boolean;
  mode: MODALMODE;
  teammateNameToDelete: string;
  teamNameInputValue: string;
}

export const useModalStore = defineStore("userModalStore", {
  state: () => ({
    isShow: false as boolean,
    mode: "" as MODALMODE,
    teammateNameToDelete: "" as string,
    teamNameInputValue: "" as string,
  }),
  getters: {
    getIsShow: (state: State) => state.isShow,
    getMode: (state: State) => state.mode,
    getTeammateNameToDelete: (state: State) => state.teammateNameToDelete,
    getTeamNameInputValue: (state: State) => state.teamNameInputValue,
  },
  actions: {
    setIsShow(isShow: boolean) {
      this.isShow = isShow;
    },
    setMode(mode: MODALMODE) {
      this.mode = mode;
    },
    setTeammateNameToDelete(teammateName: string) {
      this.teammateNameToDelete = teammateName;
    },
    setTeamNameInputValue(teamNameInputValue: string) {
      this.teamNameInputValue = teamNameInputValue;
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
      // get current teamName and set it as input value for edition
      if (teamStore.getTeamSelected.teamName && mode === MODALMODE.teamEdit) {
        this.setTeamNameInputValue(teamStore.getTeamSelected.teamName);
      }
      if (mode === MODALMODE.teamCreate || mode === MODALMODE.teamDelete) {
        this.setTeamNameInputValue("");
      }

      if (setVisible === true && mode !== null) {
        this.setMode(mode!);
      }
      this.setIsShow(setVisible);

      console.log(this.getTeamNameInputValue);
    },

    /**
     * Modal management
     * Trigger corresponding methods at modal validation depending on the current modal mode
     * See MODALMODE enum for more information
     * Called inside ModalFrame.vue.
     */
    async validationActions(): Promise<void | TeamType> {
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
     * Create a team, and select it as the current team (setTeamInfoAndFetchTeammates).
     * Refresh the team list.
     * @return createdTeam: TeamType
     */
    async handleTeamCreate(): Promise<TeamType> {
      const teamStore = useTeamStore();
      const createdTeam = await teamStore.createTeam(this.getTeamNameInputValue);
      teamStore.setTeamInfoAndFetchTeammates(createdTeam);
      await this.refreshTeamList();

      this.setTeamNameInputValue("");
      return createdTeam;
    },
    /**
     * Edit the team name. Reset the input value afterwards.
     */
    async handleTeamEdit() {
      const teamStore = useTeamStore();
      await teamStore.updateTeam(
        teamStore.getTeamSelected.id,
        teamStore.getTeamSelected.captainsId[0],
        this.getTeamNameInputValue,
        null
      );
      await this.refreshTeamList();
      this.setTeamNameInputValue("");
    },
    /**
     * Delete the team.
     * Refresh the team list.
     * @return deletedTeam: TeamType
     */
    async handleTeamDelete(): Promise<TeamType> {
      const teamStore = useTeamStore();
      const deletedTeam = await teamStore.deleteTeam(teamStore.getTeamSelected.id);
      await this.refreshTeamList();

      return deletedTeam;
    },
    /**
     * Delete a user from a team.
     * Refresh the teammate list.
     */
    async handleUserDelete() {
      const teammateStore = useTeammateStore();
      await teammateStore.deleteTeammateFromTeam(teammateStore.getIdOfTeammateToDelete);
    },

    /**
     * Refetch the team list of a given captain.
     * Get all the captainsID from the roleStore the current connected user have.
     *
     * Invoked in modalStore createNewteam / editTeamName / deleteTeam
     */
    async refreshTeamList() {
      const teamStore = useTeamStore();
      const roleStore = useRoleStore();

      await teamStore.setTeamListOfACaptain(roleStore.getCaptainsId);
    },
  }, //actions end
});
