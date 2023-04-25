import {TeamDtoIn} from "../team/team.dtoIn";
import {TeamService} from "../team/team.service";
import {TeamMateRepository} from "./teamMate.repository";
import {TeamMateWithDeclaration} from "./teamMateWithDeclaration.dtoOut";

export class TeamMateService {
  teamMateRepository: TeamMateRepository;
  teamService: TeamService;

  constructor(repository: TeamMateRepository, teamService: TeamService) {
    this.teamMateRepository = repository;
    this.teamService = teamService;
  }

  getByUserId = async (user_id: string) => {
    return await this.teamMateRepository.getByUserId(user_id);
  };

  getByTeamIdWithLastDeclaration = async (captainId: number) => {
    const team: TeamDtoIn = await this.teamService.getTeamByCaptainId(captainId);

    const getTeamMates: any[] = await this.teamMateRepository.getByTeamIdWithLastDeclaration(team.teamId);

    let result: TeamMateWithDeclaration[] = [];
    getTeamMates.forEach((element) => {
      result.push(
        new TeamMateWithDeclaration(
          element.user_id,
          element.team_mate_id,
          element.user_last_name,
          element.user_first_name,
          element.declaration_date,
          element.declaration_status
        )
      );
    });
    return result;
  };
}
