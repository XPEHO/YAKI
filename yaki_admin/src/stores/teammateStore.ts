import {UserWithIdType} from "@/models/userWithId.type";
import {teammateService} from "@/services/teammate.service";
import {defineStore} from "pinia";

export const useTeammateStore = defineStore("teammateStore", {
  state: () => ({
    teammates: [] as UserWithIdType[],
    IdOfTeammateToDelete: 0 as number,
  }),
  getters: {
    getTeammateList(): UserWithIdType[] {
      return this.teammates;
    },
    getIdOfTeammateToDelete(): number {
      return this.IdOfTeammateToDelete;
    },
  },

  actions: {
    async setListOfTeammatesWithinTeam(teamId: number): Promise<void> {
      this.teammates = await teammateService.getAllWithinTeam(teamId);
    },
    // remove a user from a team (delete his "teammate" status)
    async deleteTeammateFromTeam(id: number): Promise<void> {
      await teammateService.deleteTeammate(id);
    },
    // get the teamMateId to delete
    setIdOfTeammateToDelete(id: number) {
      this.IdOfTeammateToDelete = id;
    },
  },
});
