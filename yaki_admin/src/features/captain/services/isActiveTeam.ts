import {reactive} from "vue";

/**
 * Get the selected team from @click in v-for SideBarCaptainContent.
 * In TeamListElement compare the selected Team with the element teamName
 * If thoses are the same return true else false.
 * Apply css class if true, if false its not applied.
 */
const isTeamSelected = reactive({
  teamName: "Team 1",
  setTeam(team: string) {
    this.teamName = team;
  },
  isSameIndex(team: string) {
    if (this.teamName === team) {
      return true;
    }
    return false;
  },
});

export default isTeamSelected;
