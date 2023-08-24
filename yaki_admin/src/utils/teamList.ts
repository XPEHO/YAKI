import {useTeamStore} from "@/stores/teamStore";
import isTeamSelected from "@/features/shared/services/isSelectedTeamActive";
import modalState from "@/features/shared/services/modalState";

/**
 * invoked when user select a team.
 *
 * If the team list is not empty :
 *
 * Set the team id to apply the selection effect, fetch users from the team
 * And set the team name in the modalState
 * @param teamId
 * @returns
 */
export const selectTeamAndFetchUsers = (teamId: number) => {
  const teamStore = useTeamStore();
  if (teamStore.getTeamList.length === 0) return;

  isTeamSelected.setTeamId(teamId);
  const TeamName = teamStore.getTeamList.find((team) => team.id === teamId)?.teamName;
  modalState.setTeamName(TeamName ?? "");
  teamStore.getTeammateWithinTeam(teamId);
};
