import {TeamDtoIn} from "../team/team.dtoIn";
import {TeamService} from "../team/team.service";
import {TeammateWithDeclaration} from "./teamMateWithDeclaration.dtoOut";
import {TeammateRepository} from "./teamate.repository";

export class TeammateService {
  teamMateRepository: TeammateRepository;
  teamService: TeamService;

  constructor(repository: TeammateRepository, teamService: TeamService) {
    this.teamMateRepository = repository;
    this.teamService = teamService;
  }

  getByTeamIdWithLastDeclaration = async (captainId: number) => {
    const team: TeamDtoIn[] = await this.teamService.getTeamsByCaptainId(captainId);

    // THIS NEED TO BE CHANGED TO ALLOW A CAPTAIN TO SELECT HIS TEAM WHEN HE HANDLE SEVERAL OF THEM
    const getTeammates: any[] = await this.teamMateRepository.getByTeamIdWithLastDeclaration(team[0].teamId);

    let result: TeammateWithDeclaration[] = [];
    getTeammates.forEach((element) => {
      result.push(
        new TeammateWithDeclaration(
          element.user_id,
          element.teammate_id,
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
