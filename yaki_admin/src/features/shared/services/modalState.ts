import {reactive} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";
import {MODALMODE} from "@/features/shared/services/modalMode";
import {useTeammateStore} from "@/stores/teammateStore";
import {useRoleStore} from "@/stores/roleStore";

const modalState = reactive({
  isShowed: false as boolean,
  // for teammate to delete
  UserFirstLastName: "" as string,
  // for teams management
  mode: "" as MODALMODE,
  teamInputValue: "" as string,
  teamName: "" as string,

  /**
   * Determine modal visibility :
   *
   * If true, must set modal mode, MODALMODE enum must be used.
   * Set null if modal is going to be hidden
   * @param state : boolean to display or not the modal
   * @param mode : MODALMODE to change modal content | can be null if modal is going to be hidden
   * @param teamName : Optionnal parameter, set teamName only for edit name purpose, else ignore.
   */
  switchModalVisibility(state: boolean, mode: MODALMODE | null, teamName?: string) {
    if (teamName && mode === MODALMODE.teamEdit) {
      this.setTeamInputValue(teamName);
    } else {
      this.setTeamInputValue("");
    }
    this.isShowed = state;
    if (state === true && mode !== null) {
      this.setMode(mode!);
    }
  },

  // Modal mode is used to change modal content
  setMode(mode: MODALMODE) {
    this.mode = mode;
  },

  // for teammate to delete
  setUserFirstLastName(information: string) {
    this.UserFirstLastName = information;
  },

  /**
   * Team management.
   * Save team name
   */
  setTeamName(name: string) {
    this.teamName = name;
  },

  /**
   * Team management.
   * Save team input value
   */
  setTeamInputValue(inputvalue: string) {
    this.teamInputValue = inputvalue;
  },

  /**
   * Teammate management
   *
   * Method called inside UserCard.vue.
   * Get the user ID and retrive first name and last name which will be displayed in the modal
   */
  setTeammateIDAndInformations(id: number, informations: string) {
    const teammateStore = useTeammateStore();
    teammateStore.setIdOfTeammateToDelete(id);

    this.setUserFirstLastName(informations);
    this.switchModalVisibility(true, MODALMODE.userDelete);
  },

  /**
   *  Modal management
   *
   * Called inside ModalFrame.vue.
   * Trigger corresponding methods at modal validation, depending on modal mode
   * @returns
   */
  validationActions() {
    switch (this.mode) {
      case MODALMODE.teamCreate:
        this.createNewteam();
        return;
      case MODALMODE.teamEdit:
        this.editTeamName();
        return;
      case MODALMODE.teamDelete:
        this.deleteTeam();
        return;
      case MODALMODE.userDelete:
        this.deleteUserFromTeam();
        return;
    }
  },

  createNewteam() {
    const teamStore = useTeamStore();
    const roleStore = useRoleStore();

    teamStore.createTeam(roleStore.getCaptainsId[0], this.teamInputValue);
    this.refreshTeamList();
  },

  editTeamName() {
    const teamStore = useTeamStore();
    teamStore.updateTeam(teamStore.getSelectedTeamId, this.teamInputValue);
    this.refreshTeamList();
  },

  deleteTeam() {
    const teamStore = useTeamStore();
    teamStore.deleteTeam(teamStore.getSelectedTeamId);
    this.refreshTeamList();

    if (teamStore.getTeamList.length !== 0) {
      teamStore.setSeletedTeamTeamId(teamStore.getTeamList[0].id);
    }
  },

  deleteUserFromTeam() {
    const teammateStore = useTeammateStore();
    teammateStore.deleteTeammateFromTeam(teammateStore.getTeammateToDelete);
    this.refreshTeammatesList();
  },

  async refreshTeamList() {
    const teamStore = useTeamStore();
    const roleStore = useRoleStore();
    await setTimeout(async () => {
      await teamStore.setTeamListOfACaptain(roleStore.getCaptainsId);
    }, 100);
  },

  async refreshTeammatesList() {
    const teamStore = useTeamStore();
    const teammateStore = useTeammateStore();
    await setTimeout(async () => {
      await teammateStore.setListOfTeammatesWithinTeam(teamStore.getSelectedTeamId);
    }, 150);
  },
});

export default modalState;
