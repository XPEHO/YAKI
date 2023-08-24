import {defineStore} from "pinia";
import {teammateService} from "@/services/teammate.service";
import {teamService} from "@/services/team.service";
import {TeamType} from "@/models/team.type";
import {useSelectedRoleStore} from "./selectedRole";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    teamList: [] as TeamType[],
    // CaptainS id within a team
    captainsIdForTeamSelected: [] as number[], //captains of this team
    teamName: "" as string,
    selectedTeamId: 0 as number,
  }),
  getters: {
    getCaptainsId(): number[] {
      return this.captainsIdForTeamSelected;
    },
    getTeamName(): string {
      return this.teamName;
    },
    getTeamList(): TeamType[] {
      return this.teamList;
    },
    getSelectedTeamId(): number {
      return this.selectedTeamId;
    },
  },
  actions: {
    setTeamName(name: string) {
      this.teamName = name;
    },
    setCaptainsId(captainsId: number[]) {
      this.captainsIdForTeamSelected = captainsId;
    },
    setSeletedTeamTeamId(teamId: number): void {
      this.selectedTeamId = teamId;
    },
    isSameTeamId(teamId: number): boolean {
      if (this.selectedTeamId === teamId) {
        return true;
      }
      return false;
    },

    /**
     * set all teams for a captain list
     */
    async setTeamListOfACaptain(captainsId: number[]) {
      this.teamList = [];
      for (const captainId of captainsId) {
        const a = await teamService.getAllTeamsWithinCaptain(captainId);
        this.teamList = this.teamList.concat(a);
      }
    },

    // set all teams of a customer
    async setTeamsFromCustomer(customersId: number[]) {
      //for now we display all teams of all customers
      //but we should display only the teams of the selected customer
      //for the selected customer tab in the future
      this.teamList = [];
      for (const id of customersId) {
        const a = await teamService.getAllTeamsByCustomerId(id);
        this.teamList = this.teamList.concat(a);
      }
    },

    // add a selected user to a team
    async addUserToTeam(userId: number): Promise<void> {
      const data = {teamId: this.selectedTeamId, userId: userId};
      await teammateService.createTeammate(data);
    },

    // create a team (use captain id and team name)
    async createTeam(cptId: number, teamName: string): Promise<void> {
      const selectedRoleStore = useSelectedRoleStore();
      let customerId = selectedRoleStore.getCustomerIdSelected;
      let captainId = selectedRoleStore.getCaptainIdSelected;
      //the back handle if the captainId is null or not
      await teamService.createTeam(captainId, teamName, customerId);
    },

    // update the selected team (can change name or captainID)
    async updateTeam(teamID: number, teamName: string): Promise<void> {
      const selectedRoleStore = useSelectedRoleStore();
      let customerId = selectedRoleStore.getCustomerIdSelected;
      await teamService.updateTeam(teamID, teamName, customerId);
    },

    async deleteTeam(teamId: number): Promise<void> {
      await teamService.deleteTeam(teamId);
    },
  },
});
