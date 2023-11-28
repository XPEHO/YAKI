import {defineStore} from "pinia";
import {teammateService} from "@/services/teammate.service";
import {teamService} from "@/services/team.service";
import {TeamType} from "@/models/team.type";
import {useSelectedRoleStore} from "./selectedRole";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    teamList: [] as TeamType[],
    teamName: "" as string,
    /*  
        selectedTeamId: teamID saved 
        - on click on team in the sidebar team list
        - on press on delete icon or a team
        Use to fetch teammateList, and determine the selected team effect. 
    */
    selectedTeamId: 0 as number,

    // CaptainS id within a team
    captainsIdForTeamSelected: [] as number[],
    // id of the captain that will be assigned to a team
    captainIdToBeAssign: null as number | null,
  }),

  getters: {
    getTeamName(): string {
      return this.teamName;
    },
    getTeamList(): TeamType[] {
      return this.teamList;
    },
    getSelectedTeamId(): number {
      return this.selectedTeamId;
    },

    // NOT USED YET
    getCaptainsIdWithinTeam(): number[] {
      return this.captainsIdForTeamSelected;
    },
    getCaptainIdToBeAssign(): number | null {
      return this.captainIdToBeAssign;
    },
  },

  actions: {
    setTeamName(name: string) {
      this.teamName = name;
    },

    setSelectedTeamTeamId(teamId: number): void {
      this.selectedTeamId = teamId;
    },
    isSameTeamId(teamId: number): boolean {
      if (this.selectedTeamId === teamId) {
        return true;
      }
      return false;
    },

    setCaptainsIdWithinTeam(captainsId: number[]) {
      this.captainsIdForTeamSelected = captainsId;
    },
    setCaptainIdToBeAssign(captainId: number | null) {
      this.captainIdToBeAssign = captainId;
    },

    /**
     * will fetch the teams list of a captain
     * A captain can have multiple teams, therefore a list of captainId is needed
     */
    async setTeamListOfACaptain(captainsId: number[]) {
      this.teamList = [];
      for (const captainId of captainsId) {
        const a = await teamService.getAllTeamsWithinCaptain(captainId);
        this.teamList = this.teamList.concat(a);
      }
    },

    // set all teams of a customer
    async setTeamsFromCustomer() {
      const selectedRoleStore = useSelectedRoleStore();

      this.teamList = await teamService.getAllTeamsByCustomerId(selectedRoleStore.customerIdSelected);
    },

    // add a selected user to a team
    async addUserToTeam(userId: number): Promise<void> {
      const data = {teamId: this.selectedTeamId, userId: userId};
      await teammateService.createTeammate(data);
    },

    // create a team (use captain id and team name)
    async createTeam(teamName: string): Promise<void> {
      const selectedRoleStore = useSelectedRoleStore();
      const customerId = selectedRoleStore.getCustomerIdSelected;
      const captainId = selectedRoleStore.getCaptainIdSelected;

      //the back handle if the captainId is null or not
      await teamService.createTeam(captainId, teamName, customerId);
    },

    async createTeamOptionalAssignCaptain(teamName: string, captainId: number | null): Promise<void> {
      const selectedRoleStore = useSelectedRoleStore();
      const customerId = selectedRoleStore.getCustomerIdSelected;

      await teamService.createTeam(captainId, teamName, customerId);
    },

    // update the selected team (can change name or captainID)
    async updateTeam(
      teamID: number,
      cptId: number | null,
      teamName: string | null,
      customerId: number | null
    ): Promise<void> {
      await teamService.updateTeam(teamID, cptId, teamName, customerId);
    },

    async deleteTeam(teamId: number): Promise<void> {
      await teamService.deleteTeam(teamId);
    },
  },
});
