import {TeamType} from "./../models/team.type";
import {defineStore} from "pinia";
import {teammateService} from "@/services/teammate.service";
import {teamService} from "@/services/team.service";
import {useSelectedRoleStore} from "@/stores/selectedRole";
import {useTeammateStore} from "@/stores/teammateStore";

interface State {
  teamList: TeamType[];
  teamSelected: TeamType;
  captainIdToBeAssign: number | null;
}

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    teamList: [] as TeamType[],
    teamSelected: {} as TeamType,

    // DEPRECIATED WITH BASTI CHANGE ? ------------------------------------
    // id of the captain that will be assigned to a team
    captainIdToBeAssign: null as number | null,
  }),
  getters: {
    getTeamList: (state: State) => state.teamList,
    getTeamSelected: (state: State) => state.teamSelected,

    // DEPRECIATED WITH BASTI CHANGE ? ------------------------------------
    getCaptainIdToBeAssign: (state: State) => state.captainIdToBeAssign,
  },
  actions: {
    setTeamSelected(team: TeamType): void {
      this.teamSelected = team;
    },

    isSameTeamId(teamId: number): boolean {
      if (this.getTeamSelected.id === teamId) {
        return true;
      }
      return false;
    },

    /**
     * Save teamId and team's captainId in teamStore.
     * Save teamName in the modalStore.
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
      for (const captainId of captainsId) {
        const a = await teamService.getAllTeamsWithinCaptain(captainId);
        this.teamList = this.getTeamList.concat(a);
      }
    },

    // add a selected user to a team
    async addUserToTeam(userId: number): Promise<void> {
      const data = {teamId: this.getTeamSelected.id, userId: userId};
      await teammateService.createTeammate(data);
    },

    /**
     * Create a team, assign to the connected captain and his customer
     * @param teamName name of the team
     */
    async createTeam(teamName: string): Promise<void> {
      const selectedRoleStore = useSelectedRoleStore();
      const customerId = selectedRoleStore.getCustomerIdSelected;
      const captainId = selectedRoleStore.getCaptainIdSelected;

      //the back handle if the captainId is null or not
      await teamService.createTeam(captainId, teamName, customerId);
    },

    /**
     * Updates the team information in the database.
     *
     * @param teamID team to be updated.
     * @param cptId captain of the team. This can be null if no captain is assigned.
     * @param teamName New team name. null if the team name is not being updated.
     * @param customerId id of the customer that the team belongs to.
     *
     * @returns Resolves when the team information has been updated in the database.
     */
    async updateTeam(
      teamID: number,
      cptId: number | null,
      teamName: string | null,
      customerId: number | null
    ): Promise<void> {
      await teamService.updateTeam(teamID, cptId, teamName, customerId);
    },

    /**
     * Delete a team by its id
     * @param teamId
     */
    async deleteTeam(teamId: number): Promise<void> {
      await teamService.deleteTeam(teamId);
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
