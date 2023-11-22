import {reactive} from "vue";
import {useTeamStore} from "@/stores/teamStore.js";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";
import {useTeammateStore} from "@/stores/teammateStore";
import {useRoleStore} from "@/stores/roleStore";

const modalState = reactive({
  isShowed: false as boolean,
  // for teammate to delete
  temmateName: "" as string,
  // for teams management
  mode: "" as MODALMODE,
  teamInputValue: "" as string,
  teamName: "unknown team name" as string,

  defaultButtonValue: "Select a captain" as string,
  dropDownButtonText: "Select a captain" as string,
  dropDownSelectedCaptainId: null as number | null,

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
    this.temmateName = information;
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

  setDropDownButtonText(text: string) {
    this.dropDownButtonText = text;
  },

  setDropDownSelectedCaptainId(id: number | null) {
    this.dropDownSelectedCaptainId = id;
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
      case MODALMODE.teamCreateCustomer:
        this.createNewTeamWithOptionalCaptain();
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

  async createNewteam() {
    const teamStore = useTeamStore();
    await teamStore.createTeam(this.teamInputValue);
    this.refreshTeamList();
  },

  async createNewTeamWithOptionalCaptain() {
    const teamStore = useTeamStore();
    teamStore.createTeamOptionalAssignCaptain(this.teamInputValue, teamStore.getCaptainIdToBeAssign);
    this.refreshTeamListForCustomer();
    //reset values
    teamStore.setCaptainIdToBeAssign(null);
    this.setTeamInputValue("");
  },

  async editTeamName() {
    const teamStore = useTeamStore();
    await teamStore.updateTeam(
      teamStore.getSelectedTeamId,
      teamStore.getCaptainIdToBeAssign,
      this.teamInputValue,
      null
    );
    this.refreshTeamList();
    //reset value
    teamStore.setCaptainIdToBeAssign(null);
    this.setTeamInputValue("");
  },

  async deleteTeam() {
    const teamStore = useTeamStore();
    await teamStore.deleteTeam(teamStore.getSelectedTeamId);
    this.refreshTeamList();
    // set the first team of the list as selected team if there is at least one team
    if (teamStore.getTeamList.length !== 0) {
      teamStore.setSelectedTeamTeamId(teamStore.getTeamList[0].id);
    }
  },

  async deleteUserFromTeam() {
    const teammateStore = useTeammateStore();
    await teammateStore.deleteTeammateFromTeam(teammateStore.getIdOfTeammateToDelete);
    this.refreshTeammatesList();
  },

  /**
   * refetch the team list of a given captain.
   * Get all the captainsID from the roleStore the current connected user have
   *
   * invoked in modalState createNewteam / editTeamName / deleteTeam
   */
  refreshTeamList() {
    const teamStore = useTeamStore();
    const roleStore = useRoleStore();
    setTimeout(() => {
      teamStore.setTeamListOfACaptain(roleStore.getCaptainsId);
    }, 125);
  },

  refreshTeamListForCustomer() {
    const teamStore = useTeamStore();
    setTimeout(() => {
      teamStore.setTeamsFromCustomer();
    }, 125);
  },

  /**
   * refetch the teammate list of a given team.
   * Get the selected team id from the teamStore
   */
  refreshTeammatesList() {
    const teamStore = useTeamStore();
    const teammateStore = useTeammateStore();
    setTimeout(() => {
      teammateStore.setListOfTeammatesWithinTeam(teamStore.getSelectedTeamId);
    }, 125);
  },
});

export default modalState;
