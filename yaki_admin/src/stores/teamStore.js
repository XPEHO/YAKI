import {defineStore} from 'pinia'

export const useTeamStore = defineStore({
  id: 'team',
  state: () => ({
    team: null,
  }),
  getters: {
    getTeam() {
      return this.team
    },
  },
  actions: {
    setTeam(team) {
      this.team = team
    },
  },
})