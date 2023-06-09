import {reactive} from "vue";

/**
 * Get the selected team from @click in v-for SideBarCaptainContent.
 * In TeamListElement compare the selected Team with the element teamName
 * If thoses are the same return true else false.
 * Apply css class if true, if false its not applied.
 */
const isTeamSelected = reactive({
  id: 1,
  setTeam(teamId: number) {
    console.log(teamId);
    this.id = teamId;
  },
  isSameIndex(teamId: number) {
    if (this.id === teamId) {
      return true;
    }
    return false;
  },
});

export default isTeamSelected;
