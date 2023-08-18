import {reactive} from "vue";

/**
 * Get the selected team from @click.prevent in v-for SideBarCaptainContent.
 * In TeamListElement compare the selected Team with the element teamName
 * If thoses are the same return true else false.
 * Apply css class if true, if false its not applied.
 */
const isTeamSelected = reactive({
  id: 1 as number,

  setTeam(teamId: number): void {
    this.id = teamId;
  },

  isSameIndex(teamId: number): boolean {
    if (this.id === teamId) {
      return true;
    }
    return false;
  },
});

export default isTeamSelected;
