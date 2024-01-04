import { reactive } from "vue";
import { useTeamStore } from "@/stores/teamStore.js";
import { MODALMODE } from "@/constants/modalMode.enum";
import { useTeammateStore } from "@/stores/teammateStore";
import { useRoleStore } from "@/stores/roleStore";

// DEPRECIATED REMOVE WHEN CUSTOMER IS MADE
//==================================================================================================
const modalState = reactive({
  isShowed: false as boolean,
  temmateName: "" as string,
  mode: "" as MODALMODE,
  teamInputValue: "" as string,
  teamName: "" as string,
  teamDescription: "" as string,

  defaultButtonValue: "Select a captain" as string,
  dropDownButtonText: "Select a captain" as string,
  dropDownSelectedCaptainId: null as number | null,

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

  setMode(mode: MODALMODE) {
    this.mode = mode;
  },

  setUserFirstLastName(information: string) {
    this.temmateName = information;
  },

  setTeamName(name: string) {
    this.teamName = name;
  },

  setTeamInputValue(inputvalue: string) {
    this.teamInputValue = inputvalue;
  },

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
    await teamStore.createTeam(this.teamName, this.teamDescription);
    this.refreshTeamList();
  },

  async editTeamName() {
    const teamStore = useTeamStore();
    await teamStore.updateTeam(
      teamStore.getTeamSelected.id,
      teamStore.getTeamSelected.captainsId[0],
      this.teamInputValue,
      null,
      this.teamInputValue,
    );
    this.refreshTeamList();
    //reset value
    teamStore.setCaptainIdToBeAssign(null);
    this.setTeamInputValue("");
  },

  async deleteTeam() {
    const teamStore = useTeamStore();
    await teamStore.deleteTeam(teamStore.getTeamSelected.id);
    this.refreshTeamList();
    // set the first team of the list as selected team if there is at least one team
    if (teamStore.getTeamList.length !== 0) {
      teamStore.setTeamInfoAndFetchTeammates(teamStore.getTeamList[0]);
    }
  },

  async deleteUserFromTeam() {
    const teammateStore = useTeammateStore();
    await teammateStore.deleteTeammateFromTeam(teammateStore.getIdOfTeammateToDelete);
    this.refreshTeammatesList();
  },

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

  refreshTeammatesList() {
    const teamStore = useTeamStore();
    const teammateStore = useTeammateStore();
    setTimeout(() => {
      teammateStore.setListOfTeammatesWithinTeam(teamStore.getTeamSelected.id);
    }, 125);
  },

  async createNewTeamWithOptionalCaptain() {
    const teamStore = useTeamStore();
    teamStore.createTeamOptionalAssignCaptain(
      this.teamName,
      teamStore.getCaptainIdToBeAssign,
      this.teamDescription,
    );
    this.refreshTeamListForCustomer();
    //reset values
    teamStore.setCaptainIdToBeAssign(null);
    this.setTeamInputValue("");
  },
});

export default modalState;
