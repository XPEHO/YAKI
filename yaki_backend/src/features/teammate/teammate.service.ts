import {UserWithDeclaration} from "./userWithDeclaration.dtoOut";
import {TeammateRepository} from "./teammate.repository";
import {TeamService} from "../team/team.service";
import {TeamDtoIn} from "../team/team.dtoIn";

export class TeammateService {
  teammateRepository: TeammateRepository;
  teamService: TeamService;

  constructor(repository: TeammateRepository, teamServive: TeamService) {
    this.teammateRepository = repository;
    this.teamService = teamServive;
  }

  getByTeamIdWithLastDeclaration = async (userId: number) => {
    const teamDtoInList: TeamDtoIn[] = await this.teamService.getTeamByUserId(userId);
    const teamsIdList: number[] = teamDtoInList.map((teamDtoIn) => teamDtoIn.teamId);

    if (teamsIdList.length === 0) {
      return [];
    }

    const getTeammates: any[] = await this.teammateRepository.getByTeamIdWithLastDeclaration(teamsIdList);

    let result: UserWithDeclaration[] = [];
    getTeammates.forEach((element) => {
      result.push(
        new UserWithDeclaration(
          element.user_id,
          element.user_last_name,
          element.user_first_name,
          element.declaration_date,
          element.declaration_status,
          element.team_id,
          element.team_name,
          element.declaration_date_start,
          element.declaration_date_end,
          element.declaration_id,
          element.declaration_user_id
        )
      );
    });

    return this.getLatestDeclaration(result);
  };

  getLatestDeclaration = (declaredUsersList: UserWithDeclaration[]) => {
    const latestTeammates: UserWithDeclaration[] = [];

    declaredUsersList.forEach((currentUser) => {
      const hourStart = currentUser.declarationDateStart.getHours();
      const hourEnd = currentUser.declarationDateEnd.getHours();

      const dayStart = currentUser.declarationDateStart.toDateString();
      const dayEnd = currentUser.declarationDateEnd.toDateString();

      const isUserAlreadyInList: boolean = latestTeammates.some(
        (declaredUser) => declaredUser.userId === currentUser.userId
      );

      if (!isUserAlreadyInList) {
        if (dayStart !== dayEnd && currentUser.declarationStatus === "absence") {
          latestTeammates.push(currentUser);
          return;
        }

        if (hourStart < 9 && hourEnd > 15) {
          latestTeammates.push(currentUser);
          return;
        }

        const morning: UserWithDeclaration | undefined = declaredUsersList.find(
          (listElement) => listElement.userId === currentUser.userId && listElement.declarationDateEnd.getHours() < 13
        );
        const afternoon: UserWithDeclaration | undefined = declaredUsersList.find(
          (listElement) => listElement.userId === currentUser.userId && listElement.declarationDateStart.getHours() > 12
        );

        if (morning && afternoon) {
          latestTeammates.push(morning, afternoon);
        }
      }
    });

    return latestTeammates;
  };
}
