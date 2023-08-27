import {reactive} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";
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
   * @param setVisible : boolean to display or not the modal
   * @param mode : MODALMODE to change modal content | can be null if modal is going to be hidden
   * @param teamName : Optionnal parameter, set teamName for edit name purpose, else ignore.
   */
  switchModalVisibility(setVisible: boolean, mode: MODALMODE | null, teamName?: string) {
    if (teamName && mode === MODALMODE.teamEdit) {
      this.setTeamInputValue(teamName);
    }
    if (mode === MODALMODE.teamCreate || mode === MODALMODE.teamCreateCustomer) {
      this.setTeamInputValue("");
    }

    if (setVisible === true && mode !== null) {
      this.setMode(mode!);
    }

    this.isShowed = setVisible;
  },

  // Modal mode is used to change modal content
  // invoked in switchModalVisibility
  setMode(mode: MODALMODE) {
    this.mode = mode;
  },

  // get lastname and firstname of a user that might be deleted
  // invoked in setTeammateIDAndInformations
  setUserFirstLastName(information: string) {
    this.UserFirstLastName = information;
  },

  /**
   * Team management.
   * Save team name of the current selected team from the sidebar team list
   *
   * Called in teamList.ts
   */
  setTeamName(name: string) {
    this.teamName = name;
  },

  /**
   * Team management.
   * Save input value from the modal content handling either team creation or team name edition
   *
   * invoked in ModalContentTeam.vue and in modalState.switchModalVisibility
   */
  setTeamInputValue(inputvalue: string) {
    this.teamInputValue = inputvalue;
  },

  /**
   * Teammate management
   *
   * Get the user ID, save it in the teammateStore.
   * And retrive first name and last name to display it in the modal
   *
   * invoked in UserCard.vue
   */
  setTeammateIDAndInformations(id: number, informations: string) {
    const teammateStore = useTeammateStore();
    teammateStore.setIdOfTeammateToDelete(id);
    this.setUserFirstLastName(informations);
  },

  /**
   *  Modal management
   *
   * Trigger corresponding methods at modal validation depending on the current modal mode
   *
   * See MODALMODE enum for more information
   *
   * Called inside ModalFrame.vue.
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
    // set the first team of the list as selected team if there is at least one team
    if (teamStore.getTeamList.length !== 0) {
      teamStore.setSelectedTeamTeamId(teamStore.getTeamList[0].id);
    }
  },

  deleteUserFromTeam() {
    const teammateStore = useTeammateStore();
    teammateStore.deleteTeammateFromTeam(teammateStore.getTeammateToDelete);
    this.refreshTeammatesList();
  },

  /**
   * refetch the team list of a given captain.
   * Get all the captainsID from the roleStore the current connected user have
   *
   * invoked in modalState createNewteam / editTeamName / deleteTeam
   */
  async refreshTeamList() {
    const teamStore = useTeamStore();
    const roleStore = useRoleStore();
    await setTimeout(async () => {
      await teamStore.setTeamListOfACaptain(roleStore.getCaptainsId);
    }, 100);
  },

  /**
   * refetch the teammate list of a given team.
   * Get the selected team id from the teamStore
   */
  async refreshTeammatesList() {
    const teamStore = useTeamStore();
    const teammateStore = useTeammateStore();
    await setTimeout(async () => {
      await teammateStore.setListOfTeammatesWithinTeam(teamStore.getSelectedTeamId);
    }, 150);
  },
});

export default modalState;
