import { UserWithIdType } from "@/models/userWithId.type";
import { teammateService } from "@/services/teammate.service";
import { defineStore } from "pinia";
import { useTeamStore } from "@/stores/teamStore";
import { useModalStore } from "@/stores/modalStore";

interface State {
  teammates: UserWithIdType[];
  teammateIdToDelete: number;
}

export const useTeammateStore = defineStore("teammateStore", {
  state: () => ({
    teammates: [] as UserWithIdType[],
    teammateIdToDelete: 0 as number,
  }),
  getters: {
    getTeammateList: (state: State) => state.teammates,
    getTeammateIdToDelete: (state: State) => state.teammateIdToDelete,
  },
  actions: {
    // get the teamMateId to delete
    setTeammateIdToDelete(id: number) {
      this.teammateIdToDelete = id;
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

      await teammateService.deleteTeammate(this.teammateIdToDelete);
      //refresh teammate list
      await this.setTeammatesByTeamId(teamStore.getTeamSelected.id);

      modalStore.setTeammateNameToDelete("");
      this.setTeammateIdToDelete(0);
    },
  },
});
