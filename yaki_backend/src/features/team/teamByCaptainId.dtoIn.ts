export class TeamByCaptDtoIn {
  teamId: number;
  teamName: string;
  teamCaptainId: number;
  teamCustomerId: number;
  teamActifFlag: boolean;

  constructor(teamId: number, teamCaptainId: number, teamName: string, teamCustomerId: number, teamActifFlag: boolean) {
    this.teamId = teamId;
    this.teamName = teamName;
    this.teamCaptainId = teamCaptainId;
    this.teamCustomerId = teamCustomerId;
    this.teamActifFlag = teamActifFlag;
  }
}
