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
  teamListByCaptain: TeamType[];
  teamListByCustomer: TeamType[];
  isTeamListSetOnLoggin: boolean;
  teamSelected: TeamType;
  teamSelectedLogo: TeamLogoType;
  teamDeleted: TeamType;
  captainIdToBeAssign: number | null;
}

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    teamListByCaptain: [] as TeamType[],
    teamListByCustomer: [] as TeamType[],
    // attribute false when a user log in, and set to true when the teamListByCaptain is fetched for the very first time.
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
    getTeamListByCaptain: (state: State) => state.teamListByCaptain,
    getTeamListByCustomer: (state: State) => state.teamListByCustomer,
    // used in router.
    getIsTeamListSetOnLoggin: (state: State) => state.isTeamListSetOnLoggin,
    getTeamSelected: (state: State) => state.teamSelected,
    getTeamSelectedLogo: (state: State) => state.teamSelectedLogo,
    getTeamDeleted: (state: State) => state.teamDeleted,

    // DEPRECIATED WITH BASTI CHANGE ? ------------------------------------
    getCaptainIdToBeAssign: (state: State) => state.captainIdToBeAssign,
  },
  actions: {
    async setCurrentTeamData(teamId: number): Promise<void> {
      this.teamSelected = await teamService.getTeamDetails(teamId);
    },

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
    async setTeamsListByCaptainId(captainsId: number[]) {
      this.teamListByCaptain = [];
      const promises: Promise<TeamType[]>[] = captainsId.map((captainId) =>
        teamService.getAllTeamsWithinCaptain(captainId),
      );
      const teams = await Promise.all(promises);
      this.teamListByCaptain = [...teams.flat()];

      // change attribute value to true after the first fetch
      if (this.getIsTeamListSetOnLoggin === false) {
        this.setIsTeamListSetOnLoggin(true);
      }
    },

    /**
     * Fetch the teams list of a customer
     * A customer can have multiple teams, therefore a list of customerId is needed
     */
    async setTeamsListByCustomerId(customerId: number) {
      this.teamListByCustomer = await teamService.getAllTeamsByCustomerId(customerId);
    },

    // TEAMS CRUD METHODS  -------------------------------------------------------------------

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

      let result: TeamType = {} as TeamType;

      switch (modalStore.getMode) {
        case MODALMODE.teamCreate: {
          result = await this.createTeam();
          await this.sharedPostCrudOperations(result);

          await teamLogoStore.createOrUpdate();

          this.resetTeammatesList();
          this.resetModalInputsValues();
          break;
        }
        case MODALMODE.teamEdit: {
          result = await this.updateTeam();
          this.resetModalInputsValues();
          await this.sharedPostCrudOperations(result);
          break;
        }
        case MODALMODE.teamDelete: {
          result = await this.deleteTeam();
          this.resetTeammatesList();
          await this.sharedPostCrudOperations(result);
          break;
        }
      }

      return result;
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
      return await teamService.createTeam(
        captainId,
        modalStore.getTeamNameInputValue,
        customerId,
        modalStore.getTeamDescriptionInputValue,
      );
    },

    /**
     * Edit the team name and the team description. Reset the input value afterwards.
     * @returns updated team: TeamType.
     */
    async updateTeam(): Promise<TeamType> {
      const modalStore = useModalStore();

      return await teamService.updateTeam(
        this.getTeamSelected.id,
        this.getTeamSelected.captainsId[0],
        modalStore.getTeamNameInputValue,
        null,
        modalStore.getTeamDescriptionInputValue,
      );
    },

    /**
     * Delete a team by its id.
     * Set the teamDeleted attribute to the deleted team.
     * Reset the deleted team name in the modal store.
     * @param deletedTeam: TeamType
     * @returns return empty object to reset the teamSelected attribute.
     */
    async deleteTeam(): Promise<TeamType> {
      const deletedTeam = await teamService.deleteTeam(this.getTeamSelected.id);
      // information of the deleted team saved to be displayed in the delete team page resume (TeamStatusNotification.vue)
      this.setTeamDeleted(deletedTeam);

      return deletedTeam;
    },

    /**
     * Select the team that has been created, edited or deleted.
     * Refrech the teams list of the captain.
     * @param team
     */
    async sharedPostCrudOperations(team: TeamType): Promise<void> {
      const roleStore = useRoleStore();

      this.setTeamSelected(team);
      await this.setTeamsListByCaptainId(roleStore.getCaptainsId);
    },

    /**
     * Reset the input values of the modal store
     */
    resetModalInputsValues() {
      const modalStore = useModalStore();
      modalStore.setTeamNameInputValue("");
      modalStore.setTeamDescriptionInputValue("");
    },

    /**
     * Reset the teammate list on teammateStore (set to an empty array)
     * Invoked after team creation and team delection to restart with a empty list.
     */
    resetTeammatesList() {
      const teammateStore = useTeammateStore();
      teammateStore.resetTeamatesList();
    },

    // TEAMS LOGO METHODS -------------------------------------------------------------------

    /**
     * Get the team logo of a team given its id
     * @param teamId id of the team
     */
    async getTeamLogo(teamId: number): Promise<void> {
      const teamLogo: TeamLogoType = await teamLogoService.getTeamLogo(teamId);
      this.teamSelectedLogo = teamLogo;
    },

    /**
     * Reset the teamSelectedLogo to its initial value
     */
    resetTeamStoreSelectedLogo(): void {
      this.teamSelectedLogo = { teamId: 0, teamLogoBlob: null };
    },
  },
});
