import { TeamMateType } from "@/models/teamMate.type";
import { teamMateService } from "@/services/teamMate.service";
import { defineStore } from "pinia";

export const useTeammateStore = defineStore("teamStore", {
    state: () => ({
        teammates: [] as TeamMateType[],
        teammateToDelete: 0 as number,
    }),
    getters: {
        getTeammateList(): TeamMateType[] {
            return this.teammates;
          },
          getTeammateToDelete(): number {
            return this.teammateToDelete;
          },
        },

        actions: {
            async setTeammatesWithinTeam(teamId: number): Promise<void> {
                this.teammates = await teamMateService.getAllWithinTeam(teamId);
            },
              // remove a user from a team (delete his "teammate" status)
            async deleteTeammateFromTeam(id: number): Promise<void> {
                await teamMateService.deleteTeammate(id);
            },
                    // get the teamMateId to delete
            setTeammateToDelete(id: number) {
                this.teammateToDelete = id;
            },
    },
});
        