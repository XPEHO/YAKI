import { defineStore } from "pinia";
import { statisticsService } from "@/services/statistics.service";

export type teamActivity = {
  teamId: String;
  lastActivityDate: Date;
};

interface State {
  teamsLatestActivity: teamActivity[];
}

export const useStatisticsStore = defineStore("statisticsStore", {
  state: () => ({
    //list of latest activities for a group of teams associated to a customer
    teamsLatestActivity: [] as teamActivity[],
  }),

  getters: {
    getTeamsLatestActivity: (state: State) => state.teamsLatestActivity,
  },

  actions: {
    // API call to get the latest activites for a group of teams associated to a customer
    async setTeamsLatestActivityByCustomerId(customerId?: number, teamId?: number) {
      this.teamsLatestActivity = await statisticsService.getLatestTeamActivityByCustomerId(
        customerId,
        teamId,
      );
    },
  },
});
