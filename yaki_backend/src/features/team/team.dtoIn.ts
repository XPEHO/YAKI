export class TeamDtoIn {
  teamId: number;
  teamCaptainId: number;
  teamName: string;

  constructor(teamId: number, teamCaptainId: number, teamName: string) {
    this.teamId = teamId;
    this.teamCaptainId = teamCaptainId;
    this.teamName = teamName;
  }
}
