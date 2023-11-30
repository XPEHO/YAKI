import {MODALMODE} from "@/constants/modalMode";
import {defineStore} from "pinia";
import {useTeamStore} from "@/stores/teamStore";
import {useTeammateStore} from "@/stores/teammateStore";
import {useRoleStore} from "@/stores/roleStore";

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
     * @param mode : MODALMODE to change modal content | null if modal is going to be hidden
     * @param teamName : Optionnal parameter, set teamName for edit name purpose, else ignore.
     */
    switchModalVisibility(setVisible: boolean, mode: MODALMODE | null, teamName?: string) {
      // get current teamName and set it as input value for edition
      if (teamName && mode === MODALMODE.teamEdit) {
        this.setTeamNameInputValue(teamName);
      }
      if (mode === MODALMODE.teamCreate) {
        this.setTeamNameInputValue("");
      }

      if (setVisible === true && mode !== null) {
        this.setMode(mode!);
      }
      this.setIsShow(setVisible);
    },

    /**
     * Modal management
     * Trigger corresponding methods at modal validation depending on the current modal mode
     * See MODALMODE enum for more information
     * Called inside ModalFrame.vue.
     */
    async validationActions() {
      switch (this.getMode) {
        case MODALMODE.teamCreate:
          await this.handleTeamCreate();
          return;
        case MODALMODE.teamEdit:
          await this.handleTeamEdit();
          break;
        case MODALMODE.teamDelete:
          await this.handleTeamDelete();
          break;
        case MODALMODE.userDelete:
          await this.handleUserDelete();
          return;
      }
      this.refreshTeamList();
    },
    async handleTeamCreate() {
      const teamStore = useTeamStore();
      const createdTeam = await teamStore.createTeam(this.getTeamNameInputValue);

      teamStore.setTeamInfoAndFetchTeammates(createdTeam);

      await this.refreshTeamList();
    },
    async handleTeamEdit() {
      const teamStore = useTeamStore();
      await teamStore.updateTeam(
        teamStore.getTeamSelected.id,
        teamStore.getTeamSelected.captainsId[0],
        this.getTeamNameInputValue,
        null
      );
      this.setTeamNameInputValue("");
    },
    async handleTeamDelete() {
      const teamStore = useTeamStore();
      await teamStore.deleteTeam(teamStore.getTeamSelected.id);
    },
    async handleUserDelete() {
      const teammateStore = useTeammateStore();
      await teammateStore.deleteTeammateFromTeam(teammateStore.getIdOfTeammateToDelete);
      this.refreshTeammatesList();
      return;
    },

    /**
     * refetch the teammate list of a given team.
     * Get the selected team id from the teamStore
     */
    refreshTeammatesList() {
      const teamStore = useTeamStore();
      const teammateStore = useTeammateStore();
      setTimeout(() => {
        teammateStore.setListOfTeammatesWithinTeam(teamStore.getTeamSelected.id);
      }, 125);
    },
    /**
     * Refetch the team list of a given captain.
     * Get all the captainsID from the roleStore the current connected user have.
     *
     * Invoked in modalStore createNewteam / editTeamName / deleteTeam
     */
    refreshTeamList() {
      const teamStore = useTeamStore();
      const roleStore = useRoleStore();
      setTimeout(() => {
        teamStore.setTeamListOfACaptain(roleStore.getCaptainsId);
      }, 125);
    },
  }, //actions end
});
