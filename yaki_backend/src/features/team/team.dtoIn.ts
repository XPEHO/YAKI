export class TeamDtoIn {
  teamMateId: number;
  teamMateTeamId: number;
  teamMateUserId: number;
  teamId: number;
  teamCaptainId: number;
  teamName: string;

  constructor(
    teamMateId: number,
    teamMateTeamId: number,
    teamMateUserId: number,
    teamId: number,
    teamCaptainId: number,
    teamName: string
  ) {
    this.teamMateId = teamMateId;
    this.teamMateTeamId = teamMateTeamId;
    this.teamMateUserId = teamMateUserId;
    this.teamId = teamId;
    this.teamCaptainId = teamCaptainId;
    this.teamName = teamName;
  }
}
