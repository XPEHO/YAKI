import {defineStore} from "pinia";
import {teamMateService} from "@/services/teamMate.service";

export const useTeamStore = defineStore("teamStore", {
  state: () => ({
    team: 0,
    teammate: [],
  }),
  getters: {
    getTeam() {
      return this.team;
    },
  },
  actions: {
    async setTeam(team) {
      this.team = team;
      this.teammate = await teamMateService.getAllWithinTeam(this.team);
    },
  },
});
