import {defineStore} from "pinia";
import {teamMateService} from "@/services/teamMate.service";
import {TeammateType} from "@/models/teammate.type";
import {teamService} from "@/services/team.service";
import {TeamType} from "@/models/team.type";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    customersId: [] as number[],
    captainsId: [] as number[],
    teamSelectedId: 0 as number,
    teamName: "" as string,
    teammateList: [] as TeammateType[],
    teamList: [] as TeamType[],
    teammateToDelete: 0 as number,
    teamToDelete: 0 as number,
    customerId: 0 as number,
  }),
  getters: {
    getCustomersId(): number[] {
      return this.customersId;
    },
    getCaptainId(): number[] {
      return this.captainsId;
    },
    getTeamId(): number {
      return this.teamSelectedId;
    },
    getTeamName(): string {
      return this.teamName;
    },
    getTeammateList(): TeammateType[] {
      return this.teammateList;
    },
    getTeamList(): TeamType[] {
      return this.teamList;
    },
    getTeammateToDelete(): number {
      return this.teammateToDelete;
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
      this.captainsId = captainsId;
    },
    setCustomerId(customerId: number) {
      this.customerId = customerId;
    },
    setTeamSelectedId(teamId: number) {
      this.teamSelectedId = teamId;
    },
    // get all teams of a captain
    async getTeamsFromCaptain(captainsId: number[]) {
      this.teamList = [];
      for (const captainId of captainsId) {
        const a = await teamService.getAllTeamsWithinCaptain(captainId);
        this.teamList = this.teamList.concat(a);
      }
    },

    // get all teams of a customer
    async getTeamsFromCustomer(customersId: number[]) {
      this.teamList = [];
      for (const id of customersId) {
        const a = await teamService.getAllTeamsByCustomerId(id);
        this.teamList = this.teamList.concat(a);
      }
    },

    // get all teammate of a team
    async getTeammateWithinTeam(teamId: number): Promise<void> {
      this.teamSelectedId = teamId;
      this.teammateList = await teamMateService.getAllWithinTeam(this.teamSelectedId);
    },

    // add a selected user to a team
    async addUserToTeam(userId: number): Promise<void> {
      const data = {teamId: this.teamSelectedId, userId: userId};
      await teamMateService.createTeammate(data);
    },

    // remove a user from a team (delete his "teammate" status)
    async deleteTeammateFromTeam(id: number): Promise<void> {
      await teamMateService.deleteTeammate(id);
    },
    // get the teamMateId to delete
    setTeammateToDelete(id: number) {
      this.teammateToDelete = id;
    },

    //get the teamId to delete
    setTeamToDelete(teamId: number) {
      this.teamToDelete = teamId;
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
