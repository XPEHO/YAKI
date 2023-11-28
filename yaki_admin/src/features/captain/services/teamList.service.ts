import {useTeamStore} from "@/stores/teamStore";
import modalState from "@/features/modal/services/modalState";
import {useTeammateStore} from "@/stores/teammateStore";

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
export const selectTeamAndFetchTeammates = (teamId: number) => {
  const teamStore = useTeamStore();
  const teammateStore = useTeammateStore();

  // if team list is empty, do nothing
  if (teamStore.getTeamList.length === 0) return;

  teamStore.setSelectedTeamTeamId(teamId);

  const TeamName = teamStore.getTeamList.find((team) => team.id === teamId)!.teamName;
  modalState.setTeamName(TeamName ?? "");

  teammateStore.setListOfTeammatesWithinTeam(teamId);
};
