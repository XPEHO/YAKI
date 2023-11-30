import {UserWithIdType} from "@/models/userWithId.type";
import {teammateService} from "@/services/teammate.service";
import {defineStore} from "pinia";
import {useTeamStore} from "@/stores/teamStore";

interface State {
  teammates: UserWithIdType[];
  IdOfTeammateToDelete: number;
}

export const useTeammateStore = defineStore("teammateStore", {
  state: () => ({
    teammates: [] as UserWithIdType[],
    IdOfTeammateToDelete: 0 as number,
  }),
  getters: {
    getTeammateList: (state: State) => state.teammates,
    getIdOfTeammateToDelete: (state: State) => state.IdOfTeammateToDelete,
  },
  actions: {
    // get the teamMateId to delete
    setIdOfTeammateToDelete(id: number) {
      this.IdOfTeammateToDelete = id;
    },
    async setListOfTeammatesWithinTeam(teamId: number): Promise<void> {
      this.teammates = await teammateService.getAllWithinTeam(teamId);
    },
    // remove a user from a team (delete his "teammate" status)
    async deleteTeammateFromTeam(id: number): Promise<void> {
      const teamStore = useTeamStore();
      await teammateService.deleteTeammate(id);
      //refresh teammate list
      await this.setListOfTeammatesWithinTeam(teamStore.getTeamSelected.id);
    },
  },
});
