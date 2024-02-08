import { UserWithIdType } from "@/models/userWithId.type";
import { teammateService } from "@/services/teammate.service";
import { defineStore } from "pinia";
import { useTeamStore } from "@/stores/teamStore";
import { useModalStore } from "@/stores/modalStore";

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
    resetTeamatesList() {
      this.teammates = [];
    },
    async setTeammatesByTeamId(teamId: number): Promise<void> {
      this.teammates = await teammateService.getAllWithinTeam(teamId);
    },

    // add a selected user to a team
    async addTeammateToTeam(userId: number): Promise<void> {
      const teamStore = useTeamStore();

      const data = { teamId: teamStore.getTeamSelected.id, userId: userId };
      await teammateService.createTeammate(data);
      await this.setTeammatesByTeamId(teamStore.getTeamSelected.id);
    },

    /**
     * Delete a user from a team.
     * Refresh the teammate list.
     */
    async deleteTeammateFromTeam(): Promise<void> {
      const teamStore = useTeamStore();
      const modalStore = useModalStore();

      await teammateService.deleteTeammate(this.IdOfTeammateToDelete);
      //refresh teammate list
      await this.setTeammatesByTeamId(teamStore.getTeamSelected.id);

      modalStore.setTeammateNameToDelete("");
      this.setIdOfTeammateToDelete(0);
    },
  },
});
