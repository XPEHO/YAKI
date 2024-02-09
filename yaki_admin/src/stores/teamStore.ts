import { TeamType } from "./../models/team.type";
import { defineStore } from "pinia";
import { teamService } from "@/services/team.service";
import { useSelectedRoleStore } from "@/stores/selectedRole";
import { useTeammateStore } from "@/stores/teammateStore";
import { teamLogoService } from "@/services/teamLogo.service";
import { TeamLogoType } from "@/models/TeamLogo.type";
import { MODALMODE } from "@/constants/modalMode.enum";
import { useModalStore } from "@/stores/modalStore";
import { useRoleStore } from "@/stores/roleStore";
import { useTeamLogoStore } from "./teamLogoStore";

interface State {
  teamList: TeamType[];
  isTeamListSetOnLoggin: boolean;
  teamSelected: TeamType;
  teamSelectedLogo: TeamLogoType;
  teamDeleted: TeamType;
  captainIdToBeAssign: number | null;
}

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    teamList: [] as TeamType[],
    // attribute false when a user log in, and set to true when the teamList is fetched for the very first time.
    // This way the router will not trigger fetch everytime the user navigate to the captain page.
    isTeamListSetOnLoggin: false as boolean,
    teamSelected: {} as TeamType,
    teamSelectedLogo: { teamId: 0, teamLogoBlob: null } as TeamLogoType,
    teamDeleted: {} as TeamType,

    // DEPRECIATED WITH BASTI CHANGE ? ------------------------------------
    // id of the captain that will be assigned to a team
    captainIdToBeAssign: null as number | null,
  }),
  getters: {
    getTeamList: (state: State) => state.teamList,
    getIsTeamListSetOnLoggin: (state: State) => state.isTeamListSetOnLoggin,
    getTeamSelected: (state: State) => state.teamSelected,
    getTeamSelectedLogo: (state: State) => state.teamSelectedLogo,
    getTeamDeleted: (state: State) => state.teamDeleted,

    // DEPRECIATED WITH BASTI CHANGE ? ------------------------------------
    getCaptainIdToBeAssign: (state: State) => state.captainIdToBeAssign,
  },
  actions: {
    setIsTeamListSetOnLoggin(isTeamListSet: boolean): void {
      this.isTeamListSetOnLoggin = isTeamListSet;
    },
    setTeamSelected(team: TeamType): void {
      this.teamSelected = team;
    },
    setTeamDeleted(team: TeamType): void {
      this.teamDeleted = team;
    },
    isSameTeamId(teamId: number): boolean {
      if (this.getTeamSelected.id === teamId) {
        return true;
      }
      return false;
    },

    // Move this methide to the teammateStore ?
    /**
     * save team info in the store (teamSelected)
     * And trigger the team's teammates fetch.
     * @param team TeamType
     */
    async setTeamSelectedAndFetchTeammates(team: TeamType): Promise<void> {
      const teammateStore = useTeammateStore();

      // fetch team teammates
      await teammateStore.setTeammatesByTeamId(team.id);

      // if same team is selected, no need to set the team info again, and fetch the logo again
      if (this.getTeamSelected.id === team.id) return;

      this.setTeamSelected(team);
      this.getTeamLogo(team.id);
    },

    /**
     * will fetch the teams list of a captain
     * A captain can have multiple teams, therefore a list of captainId is needed
     */
    async setTeamListOfACaptain(captainsId: number[]) {
      this.teamList = [];
      const promises: Promise<TeamType[]>[] = captainsId.map((captainId) =>
        teamService.getAllTeamsWithinCaptain(captainId),
      );
      const teams = await Promise.all(promises);
      this.teamList = [...teams.flat()];

      // change attribute value to true after the first fetch
      if (this.getIsTeamListSetOnLoggin === false) {
        this.setIsTeamListSetOnLoggin(true);
      }
    },

    // TEAMS CRUD METHODS

    /**
     * Invoked in ModalFrameView, when user click on "validation" button in modal
     *
     * Trigger corresponding methods depending on the current modal mode set when invoking switchModalVisibility.
     * See MODALMODE enum for more information
     *
     * Actions :
     *
     * * teamCreate : create a team (the create or update logo will also be triggered if a logo is set in the modal)
     * * teamEdit : edit a team informations
     * * teamDelete : delete a team from the logged captain's team list
     */
    async crudOperations(): Promise<void | TeamType> {
      const modalStore = useModalStore();
      const teamLogoStore = useTeamLogoStore();

      switch (modalStore.getMode) {
        case MODALMODE.teamCreate: {
          const createdTeam = await this.createTeam();
          await teamLogoStore.createOrUpdate();
          return createdTeam;
        }
        case MODALMODE.teamEdit:
          await this.updateTeam();
          return;
        case MODALMODE.teamDelete:
          return await this.deleteTeam();
      }
    },

    /**
     * Create a team, and select it as the current team (setTeamSelected).
     * Reset the teammate list on teamateStore, as a new team do not come with teammates.
     * (it preventy to do an API call to fetch the teammate list)
     * Refresh the team list.
     * @returns created team: TeamType
     */
    async createTeam(): Promise<TeamType> {
      const selectedRoleStore = useSelectedRoleStore();
      const modalStore = useModalStore();

      const customerId = selectedRoleStore.getCustomerIdSelected;
      const captainId = selectedRoleStore.getCaptainIdSelected;

      //the back handle if the captainId is null or not
      const createdTeam = await teamService.createTeam(
        captainId,
        modalStore.getTeamNameInputValue,
        customerId,
        modalStore.getTeamDescriptionInputValue,
      );

      await this.selectTeamRefreshListResetInputs(createdTeam);
      this.resetTeammateList();

      return createdTeam;
    },

    /**
     * Delete a team by its id
     * @param deletedTeam: TeamType
     */
    async deleteTeam(): Promise<TeamType> {
      const modalStore = useModalStore();

      const deletedTeam = await teamService.deleteTeam(this.getTeamSelected.id);
      // information of the deleted team saved to be displayed in the delete team page resume (TeamStatusNotification.vue)
      this.setTeamDeleted(deletedTeam);
      // reset store values after team deletion
      modalStore.setTeammateNameToDelete("");

      await this.selectTeamRefreshListResetInputs({} as TeamType);
      this.resetTeammateList();

      return this.getTeamDeleted;
    },

    /**
     * Edit the team name and the team description. Reset the input value afterwards.
     * @returns updated team: TeamType.
     */
    async updateTeam(): Promise<TeamType> {
      const modalStore = useModalStore();

      const editedTeam = await teamService.updateTeam(
        this.getTeamSelected.id,
        this.getTeamSelected.captainsId[0],
        modalStore.getTeamNameInputValue,
        null,
        modalStore.getTeamDescriptionInputValue,
      );

      await this.selectTeamRefreshListResetInputs(editedTeam);

      return editedTeam;
    },

    /**
     * * Set the team be to selected in the team list.
     * * Refresh the team list to reflect any list team change (Get again the team list of the current captain)
     * * Reset the input value of the modal (teamNameInputValue, teamDescriptionInputValue)
     * @param team TeamType Team to be selected
     */
    async selectTeamRefreshListResetInputs(team: TeamType) {
      this.setTeamSelected(team);

      const roleStore = useRoleStore();
      await this.setTeamListOfACaptain(roleStore.getCaptainsId);

      const modalStore = useModalStore();
      modalStore.setTeamNameInputValue("");
      modalStore.setTeamDescriptionInputValue("");
    },

    /**
     * Reset the teammate list on teammateStore (set to an empty array)
     * Invoked after team creation and team delection to restart with a empty list.
     */
    resetTeammateList() {
      const teammateStore = useTeammateStore();
      teammateStore.resetTeamatesList();
    },

    // TEAMS LOGO METHODS

    /**
     * Get the team logo of a team given its id
     * @param teamId id of the team
     */
    async getTeamLogo(teamId: number): Promise<void> {
      const teamLogo: TeamLogoType = await teamLogoService.getTeamLogo(teamId);
      this.teamSelectedLogo = teamLogo;
    },

    /**
     * Fetch the team logo of a team
     * @param teamId id of the team
     * @returns TeamLogoType
     * @throws Error if the team logo is not found
     */
    async createOrUpdateTeamLogo(logo: File): Promise<void> {
      const teamId = this.getTeamSelected.id;
      const savedTeamLogo: TeamLogoType = await teamLogoService.createOrUpdateTeamLogo(
        teamId,
        logo,
      );

      if (savedTeamLogo.teamLogoBlob === null) return;

      this.teamSelectedLogo = savedTeamLogo;
    },

    async deleteTeamLogo(): Promise<void> {
      teamLogoService.deleteTeamLogo(this.getTeamSelected.id);
      this.resetTeamStoreSelectedLogo();
    },

    /**
     * Reset the teamSelectedLogo to its initial value
     */
    resetTeamStoreSelectedLogo(): void {
      this.teamSelectedLogo = { teamId: 0, teamLogoBlob: null };
    },
  },
});
