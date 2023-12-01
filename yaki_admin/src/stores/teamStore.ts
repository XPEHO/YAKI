import {TeamType} from "./../models/team.type";
import {defineStore} from "pinia";
import {teammateService} from "@/services/teammate.service";
import {teamService} from "@/services/team.service";
import {useSelectedRoleStore} from "@/stores/selectedRole";
import {useTeammateStore} from "@/stores/teammateStore";

interface State {
  teamList: TeamType[];
  isTeamListSetOnLoggin: boolean;
  teamSelected: TeamType;
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
    teamDeleted: {} as TeamType,

    // DEPRECIATED WITH BASTI CHANGE ? ------------------------------------
    // id of the captain that will be assigned to a team
    captainIdToBeAssign: null as number | null,
  }),
  getters: {
    getTeamList: (state: State) => state.teamList,
    getIsTeamListSetOnLoggin: (state: State) => state.isTeamListSetOnLoggin,
    getTeamSelected: (state: State) => state.teamSelected,
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

    /**
     * save team info in the store (teamSelected)
     * And trigger the team's teammates fetch.
     * @param team TeamType
     */
    setTeamInfoAndFetchTeammates(team: TeamType): void {
      const teammateStore = useTeammateStore();
      this.setTeamSelected(team);
      // fetch team teammates
      teammateStore.setListOfTeammatesWithinTeam(team.id);
    },

    /**
     * will fetch the teams list of a captain
     * A captain can have multiple teams, therefore a list of captainId is needed
     */
    async setTeamListOfACaptain(captainsId: number[]) {
      this.teamList = [];
      const promises: Promise<TeamType[]>[] = captainsId.map((captainId) =>
        teamService.getAllTeamsWithinCaptain(captainId)
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
      const data = {teamId: this.getTeamSelected.id, userId: userId};
      await teammateService.createTeammate(data);
      await teammateStore.setListOfTeammatesWithinTeam(this.getTeamSelected.id);
    },

    /**
     * Create a team, assign to the connected captain and his customer
     * @param teamName name of the team
     * @returns created team: TeamType
     */
    async createTeam(teamName: string): Promise<TeamType> {
      const selectedRoleStore = useSelectedRoleStore();
      const customerId = selectedRoleStore.getCustomerIdSelected;
      const captainId = selectedRoleStore.getCaptainIdSelected;

      //the back handle if the captainId is null or not
      return await teamService.createTeam(captainId, teamName, customerId);
    },

    /**
     * Updates the team information in the database.
     *
     * @param teamID team to be updated.
     * @param cptId captain of the team. This can be null if no captain is assigned.
     * @param teamName New team name. null if the team name is not being updated.
     * @param customerId id of the customer that the team belongs to.
     *
     * @returns updated team: TeamType.
     */
    async updateTeam(
      teamID: number,
      cptId: number | null,
      teamName: string | null,
      customerId: number | null
    ): Promise<TeamType> {
      return await teamService.updateTeam(teamID, cptId, teamName, customerId);
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

    // DEPRECIATED WITH BASTI CHANGE ? ---------------------------------------------------------------

    setCaptainIdToBeAssign(captainId: number | null) {
      this.captainIdToBeAssign = captainId;
    },

    async createTeamOptionalAssignCaptain(teamName: string, captainId: number | null): Promise<void> {
      const selectedRoleStore = useSelectedRoleStore();
      const customerId = selectedRoleStore.getCustomerIdSelected;

      await teamService.createTeam(captainId, teamName, customerId);
    },

    /**
     * will fetch the teams list of a customer.
     * And assign it to the teamList
     */
    async setTeamsFromCustomer() {
      const selectedRoleStore = useSelectedRoleStore();

      this.teamList = await teamService.getAllTeamsByCustomerId(selectedRoleStore.customerIdSelected);
    },
  },
});
