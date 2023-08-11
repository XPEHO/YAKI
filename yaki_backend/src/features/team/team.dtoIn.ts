export class TeamDtoIn {
  teamId: number;
  teamName: string;
  teamActifFlag: boolean;

  constructor(teamId: number, teamName: string, teamActifFlag: boolean) {
    this.teamId = teamId;
    this.teamName = teamName;
    this.teamActifFlag = teamActifFlag;
  }
}
