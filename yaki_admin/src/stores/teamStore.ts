import { defineStore } from "pinia";
import { teamMateService } from "@/services/teammate.service";
import { teamService } from "@/services/team.service";
import { TeamType } from "@/models/team.type";
import { useTeammateStore } from "./teammateStore";
import { useSelectedRoleStore } from "./selectedRole";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    teamList: [] as TeamType[],
    teamSelectedId: 0 as number,
    captainsIdForTeamSelected: [] as number[], //captains of this team
    teamName: "" as string,
  }),
  getters: {
    getCaptainsId(): number[] {
      return this.captainsIdForTeamSelected;
    },
    getTeamId(): number {
      return this.teamSelectedId;
    },
    getTeamName(): string {
      return this.teamName;
    },
    getTeamList(): TeamType[] {
      return this.teamList;
    },

  },
  actions: {
    setTeamName(name: string) {
      this.teamName = name;
    },
    setCaptainsId(captainsId: number[]) {
      this.captainsIdForTeamSelected = captainsId;
    },
    setTeamSelectedId(teamId: number) {
      const teammateStore = useTeammateStore();
      this.teamSelectedId = teamId;
      teammateStore.setTeammatesWithinTeam(teamId);
    },
    // set all teams for a captain list
    async setTeamsFromCaptain(captainsId: number[]) {
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
      const data = {teamId: this.teamSelectedId, userId: userId};
      await teamMateService.createTeammate(data);
    },
    
    // create a team (use captain id and team name)
    async createTeam(cptId: number, teamName: string): Promise<void> {
      const selectedRoleStore = useSelectedRoleStore();
      let customerId = selectedRoleStore.getCustomerIdSelected;
      let captainId = selectedRoleStore.getCaptainIdSelected;
      //the back handle if the captainId is null or not
      await teamService.createTeam(captainId, teamName, customerId);
      this.setTeamSelectedId(this.teamList.length);
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
