import { TeamType } from "./../models/team.type";
import { defineStore } from "pinia";
import { teammateService } from "@/services/teammate.service";
import { teamService } from "@/services/team.service";
import { useSelectedRoleStore } from "@/stores/selectedRole";
import { useTeammateStore } from "@/stores/teammateStore";
import { teamLogoService } from "@/services/teamLogo.service";
import { TeamLogoType } from "@/models/TeamLogo.type";

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
    async setTeamInfoAndFetchTeammates(team: TeamType): Promise<void> {
      const teammateStore = useTeammateStore();

      // fetch team teammates
      await teammateStore.setListOfTeammatesWithinTeam(team.id);

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

    // add a selected user to a team
    async addUserToTeam(userId: number): Promise<void> {
      const teammateStore = useTeammateStore();
      const data = { teamId: this.getTeamSelected.id, userId: userId };
      await teammateService.createTeammate(data);
      await teammateStore.setListOfTeammatesWithinTeam(this.getTeamSelected.id);
    },

    /**
     * Create a team, assign to the connected captain and his customer
     * @param teamName name of the team
     * @param teamDescription description of the team
     * @returns created team: TeamType
     */
    async createTeam(teamName: string, teamDescription: string): Promise<TeamType> {
      const selectedRoleStore = useSelectedRoleStore();
      const customerId = selectedRoleStore.getCustomerIdSelected;
      const captainId = selectedRoleStore.getCaptainIdSelected;

      //the back handle if the captainId is null or not
      return await teamService.createTeam(captainId, teamName, customerId, teamDescription);
    },

    /**
     * Updates the team information in the database.
     *
     * @param teamID team to be updated.
     * @param cptId captain of the team. This can be null if no captain is assigned.
     * @param teamName New team name. null if the team name is not being updated.
     * @param customerId id of the customer that the team belongs to.
     * @param teamDescription New team description. null if the team description is not being updated.
     * @returns updated team: TeamType.
     */
    async updateTeam(
      teamID: number,
      cptId: number | null,
      teamName: string | null,
      customerId: number | null,
      teamDescription: string | null,
    ): Promise<TeamType> {
      return await teamService.updateTeam(teamID, cptId, teamName, customerId, teamDescription);
    },

    /**
     * Delete a team by its id
     * @param deletedTeam: TeamType
     */
    async deleteTeam(teamId: number): Promise<TeamType> {
      const deletedTeam = await teamService.deleteTeam(teamId);
      this.setTeamDeleted(deletedTeam);
      return this.getTeamDeleted;
    },

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

    // ----------------------------------------------------------------------------------------------
    // DEPRECIATED WITH BASTI CHANGE ? ---------------------------------------------------------------

    setCaptainIdToBeAssign(captainId: number | null) {
      this.captainIdToBeAssign = captainId;
    },

    async createTeamOptionalAssignCaptain(
      teamName: string,
      captainId: number | null,
      teamDescription: string,
    ): Promise<void> {
      const selectedRoleStore = useSelectedRoleStore();
      const customerId = selectedRoleStore.getCustomerIdSelected;

      await teamService.createTeam(captainId, teamName, customerId, teamDescription);
    },

    /**
     * will fetch the teams list of a customer.
     * And assign it to the teamList
     */
    async setTeamsFromCustomer() {
      const selectedRoleStore = useSelectedRoleStore();

      this.teamList = await teamService.getAllTeamsByCustomerId(
        selectedRoleStore.customerIdSelected,
      );
    },
  },
});
