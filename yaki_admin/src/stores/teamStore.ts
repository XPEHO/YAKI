import { defineStore } from "pinia";
import { teamMateService } from "@/services/teamMate.service";
import { teamService } from "@/services/team.service";
import { TeamType } from "@/models/team.type";
import { useTeammateStore } from "./teammateStore";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    teamList: [] as TeamType[],
    teamSelectedId: 0 as number,
    customersId: [] as number[], //useless ?
    captainsIdForTeamSelected: [] as number[], //captains of this team
    teamName: "" as string,
    customerId: 0 as number,//useless ?
  }),
  getters: {
    getCustomersId(): number[] {
      return this.customersId;
    },
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
    setCustomersId(customersId: number[]) {
      this.customersId = customersId;
    },
    setCaptainsId(captainsId: number[]) {
      this.captainsIdForTeamSelected = captainsId;
    },
    setCustomerId(customerId: number) {
      this.customerId = customerId;
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
      await teamService.createTeam(cptId, teamName, this.customerId);
      this.setTeamSelectedId(this.teamList.length);
    },

    // update the selected team (can change name or captainID)
    async updateTeam(teamID: number, teamName: string): Promise<void> {
      await teamService.updateTeam(teamID, teamName, this.customerId);
    },

    async deleteTeam(teamId: number): Promise<void> {
      await teamService.deleteTeam(teamId);
    },
  },
});
