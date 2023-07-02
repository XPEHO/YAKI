import {defineStore} from "pinia";
import {teamMateService} from "@/services/teamMate.service";
import {TeamMateType} from "@/models/teamMate.type";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    team: 0 as number,
    teammate: [] as TeamMateType[],
  }),
  getters: {
    getTeam(): number {
      return this.team;
    },
  },
  actions: {
    async getTeammateWithinTeam(team: number) {
      this.team = team;
      this.teammate = await teamMateService.getAllWithinTeam(this.team);
    },

    async addUserToTeam(userId: number) {
      await teamMateService.createTeammate({userId: userId, teamId: this.team});
    },
  },
});
