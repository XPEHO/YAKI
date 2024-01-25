export class TeamLogoDto {
  teamLogoTeamId: number;
  teamLogoBlob: Buffer | null;

  constructor(teamLogoTeamId: number, teamLogoBlob: Buffer | null) {
    this.teamLogoTeamId = teamLogoTeamId;
    this.teamLogoBlob = teamLogoBlob;
  }
}
