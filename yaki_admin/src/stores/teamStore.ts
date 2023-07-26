import {defineStore} from "pinia";
import {teamMateService} from "@/services/teamMate.service";
import {TeamMateType} from "@/models/teamMate.type";
import {teamService} from "@/services/team.service";
import {TeamType} from "@/models/team.type";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    captainsId: [343] as number[],
    teamId: 0 as number,
    teamName: "" as string,
    teammate: [] as TeamMateType[],
    teamList: [] as TeamType[],
    teammateToDelete: 0 as number,
    customerId: 0 as number,
  }),
  getters: {
    getCaptainId(): number[] {
      return this.captainsId;
    },
    getTeamId(): number {
      return this.teamId;
    },
    getTeamName(): string {
      return this.teamName;
    },
    getTeammateList(): TeamMateType[] {
      return this.teammate;
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
    setCaptainsId(captainsId: number[]){
      this.captainsId = captainsId;
    },
    setCustomerId(customerId: number){
      this.customerId = customerId;
    },
    // get all teams of a captain
    async getTeamsFromCaptain(captainsId: number[]) {
      this.teamList = []
      for (let captainId of captainsId){
        let a =  await teamService.getAllTeamsWithinCaptain(captainId);
        this.teamList = this.teamList.concat(a)
      }
    },

    // get all teammate of a team
    async getTeammateWithinTeam(teamId: number): Promise<void> {
      this.teamId = teamId;
      this.teammate = await teamMateService.getAllWithinTeam(this.teamId);
    },

    // add a selected user to a team
    async addUserToTeam(userId: number): Promise<void> {
      const data = {teamId: this.teamId, userId: userId, customerId: this.customerId};
      await teamMateService.createTeammate(data);
    },

    // remove a user from a team (delete his "teammate" status)
    async deleteTeammateFromTeam(id: number): Promise<void> {
      await teamMateService.deleteTeammate(id);
    },
    // get the teamId to delete
    setTeammateToDelete(id: number) {
      this.teammateToDelete = id;
    },

    // create a team (use captain id and team name)
    async createTeam(cptId: number, teamName: string): Promise<void> {
      await teamService.createTeam(cptId, teamName,this.customerId);
    },

    // update the selected team (can change name or captainID)
    async updateTeam(teamID: number, teamName: string): Promise<void> {
      await teamService.updateTeam(teamID, teamName,this.customerId);
    },

    async deleteTeam(teamId: number): Promise<void> {
      await teamService.deleteTeam(teamId);
    },
  },
});
