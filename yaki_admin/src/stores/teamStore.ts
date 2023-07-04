import {defineStore} from "pinia";
import {teamMateService} from "@/services/teamMate.service";
import {TeamMateType} from "@/models/teamMate.type";
import {teamService} from "@/services/team.service";
import {TeamType} from "@/models/team.type";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    team: 0 as number,
    teammate: [] as TeamMateType[],
    teamList: [] as TeamType[],
    teammateToDelete: 0 as number,
  }),
  getters: {
    getCurrentTeam(): number {
      return this.team;
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
    async getTeamsFromCaptain(id: number) {
      this.teamList = await teamService.getAllTeamsWithinCaptain(id);
    },

    async getTeammateWithinTeam(team: number): Promise<void> {
      this.team = team;
      this.teammate = await teamMateService.getAllWithinTeam(this.team);
    },

    async addUserToTeam(userId: number): Promise<void> {
      const data = {teamId: this.team, userId: userId};
      await teamMateService.createTeammate(data);
    },

    setTeammateToDelete(id: number) {
      this.teammateToDelete = id;
    },

    async deleteTeammateFromTeam(id: number): Promise<void> {
      await teamMateService.deleteTeammate(id);
    },
  },
});
