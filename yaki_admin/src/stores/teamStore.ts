import {defineStore} from "pinia";
import {teamMateService} from "@/services/teamMate.service";
import {TeamMateType} from "@/models/teamMate.type";
import {teamService} from "@/services/team.service";
import {TeamType} from "@/models/team.type";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    captainId: 343 as number,
    teamId: 0 as number,
    teamName: "" as string,
    teammate: [] as TeamMateType[],
    teamList: [] as TeamType[],
    teammateToDelete: 0 as number,
  }),
  getters: {
    getCaptainId(): number {
      return this.captainId;
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

    // get all teams of a captain
    async getTeamsFromCaptain(captainId: number) {
      this.teamList = await teamService.getAllTeamsWithinCaptain(captainId);
    },

    // get all teammate of a team
    async getTeammateWithinTeam(teamId: number): Promise<void> {
      this.teamId = teamId;
      this.teammate = await teamMateService.getAllWithinTeam(this.teamId);
    },

    // add a selected user to a team
    async addUserToTeam(userId: number): Promise<void> {
      const data = {teamId: this.teamId, userId: userId};
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
      await teamService.createTeam(cptId, teamName);
    },

    // update the selected team (can change name or captainID)
    async updateTeam(teamID: number, cptId: number, teamName: string): Promise<void> {
      await teamService.updateTeam(teamID, cptId, teamName);
    },

    async deleteTeam(teamId: number): Promise<void> {
      await teamService.deleteTeam(teamId);
    },
  },
});
