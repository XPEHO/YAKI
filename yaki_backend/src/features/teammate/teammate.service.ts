import {UserWithDeclaration} from "./userWithDeclaration.dtoOut";
import {TeammateRepository} from "./teammate.repository";
import {TeamService} from "../team/team.service";
import {AbsenceDeclarationDto} from "./absenceDeclaration.dto";
import {UserWithDeclarationDepreciated} from "./userWithDeclarationDepreciated.dto";
import {TeamDtoIn} from "../team/team.dtoIn";

export class TeammateService {
  teammateRepository: TeammateRepository;
  teamService: TeamService;

  constructor(repository: TeammateRepository, teamServive: TeamService) {
    this.teammateRepository = repository;
    this.teamService = teamServive;
  }

  // DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
  //========================================================
  getByTeamIdWithLastDeclaration = async (userId: number) => {
    const teamDtoInList: TeamDtoIn[] = await this.teamService.getTeamByUserId(userId);
    const teamsIdList: number[] = teamDtoInList.map((teamDtoIn) => teamDtoIn.teamId);

    if (teamsIdList.length === 0) {
      return [];
    }

    const getTeammates: any[] = await this.teammateRepository.getByTeamIdWithLastDeclaration(teamsIdList);

    let result: UserWithDeclarationDepreciated[] = [];
    getTeammates.forEach((element) => {
      result.push(
        new UserWithDeclarationDepreciated(
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
  // DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
  //========================================================
  getLatestDeclaration = (declaredUsersList: UserWithDeclarationDepreciated[]) => {
    const latestTeammates: UserWithDeclarationDepreciated[] = [];

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

        const morning: UserWithDeclarationDepreciated | undefined = declaredUsersList.find(
          (listElement) => listElement.userId === currentUser.userId && listElement.declarationDateEnd.getHours() < 13
        );
        const afternoon: UserWithDeclarationDepreciated | undefined = declaredUsersList.find(
          (listElement) => listElement.userId === currentUser.userId && listElement.declarationDateStart.getHours() > 12
        );

        if (morning && afternoon) {
          latestTeammates.push(morning, afternoon);
        }
      }
    });

    return latestTeammates;
  };

  /**
   * Invoke getUsersIdFromTeamsWhereUserIsInto from teammateRepository.
   * Get all users id from teams where selected user is into.
   * @param userId selected user id
   * @returns number[]
   */
  getUsersIdFromTeamsWhereUserIsInto = async (userId: number) => {
    if (userId == null && typeof userId !== "number") {
      throw TypeError("No user id or incorrect id type");
    }
    return await this.teammateRepository.getUsersIdFromTeamsWhereUserIsInto(userId);
  };

  /**
   * Will retrive all teammates's declarations from the same team as the selected user.
   * - 1 Get all users id of teammates being in the same team as the selected user.
   * - 2 Get each user's declarations given the previewsly obtain users id list.
   * - 3 If one of more user(s) from the list has no declaration, check if this/thoses users have an absence.
   * - 4 Otherwise the userWithDeclaration object is unchanged. Leading to a undeclared user.
   * @param userId the userId of the user who wants to see his teammates declarations
   * @returns List of UserWithDeclaration
   */
  getTeammatesDeclarationsFromUserTeams = async (userId: number) => {
    const usersIdList = await this.getUsersIdFromTeamsWhereUserIsInto(userId);

    if (usersIdList.length === 0) {
      throw TypeError("There are no users to search for a declaration.");
    }

    const usersWithDeclarations: any[] = await this.teammateRepository.getTeammatesDeclarationsFromUserTeams(
      usersIdList
    );

    let result: UserWithDeclaration[] = [];
    usersWithDeclarations.forEach((element) => {
      result.push(
        new UserWithDeclaration(
          element.user_id,
          element.user_last_name,
          element.user_first_name,
          element.declaration_date,
          element.declaration_date_start,
          element.declaration_date_end,
          element.declaration_status,
          element.team_id,
          element.team_name,
          element.team_customer_id,
          element.customer_name
        )
      );
    });

    return await this.ifAbsenceInsertData(result);
  };

  /**
   * Invoke getUsersAbsence from teammateRepository.
   * If exist, retrive all selected users absence.
   * @param usersId users without current day declaration : number[]
   */
  getUsersAbsence = async (usersId: number[]) => {
    const absenceList: any[] = await this.teammateRepository.getUsersAbsence(usersId);

    let result: AbsenceDeclarationDto[] = [];
    absenceList.forEach((absence) => {
      result.push(
        new AbsenceDeclarationDto(
          absence.declaration_user_id,
          absence.declaration_date,
          absence.declaration_date_start,
          absence.declaration_date_end,
          absence.declaration_status
        )
      );
    });
    return result;
  };

  /**
   * If one of more user(s) from the list has no declaration, check if this/thoses users have an absence.
   * If yes, insert absence data (dates and status) into the corresponding userWitherDeclaration object.
   * Otherwise the userWithDeclaration object is unchanged. Leading to a undeclared user.
   * @param usersList the list of users with their declaration ( or lack of declaration)
   * @returns
   */
  async ifAbsenceInsertData(usersList: UserWithDeclaration[]): Promise<UserWithDeclaration[]> {
    const undeclaredUsers: UserWithDeclaration[] = usersList.filter(
      (user) => user.declarationStatus == null && user.declarationDate == null
    );
    //exit if all users have a declaration
    if (undeclaredUsers.length === 0) return usersList;

    const undeclaredUsersId: number[] = undeclaredUsers.map((user) => user.userId);
    const usersAbsence: AbsenceDeclarationDto[] = await this.getUsersAbsence(undeclaredUsersId);

    // users without declaration don't necessarily have an absence
    if (usersAbsence.length === 0) return usersList;

    const usersAbsenceMap = new Map(usersAbsence.map((absence) => [absence.declarationUserId, absence]));
    for (let i = 0; i < usersList.length; i++) {
      const currentUser = usersList[i];
      const absence = usersAbsenceMap.get(currentUser.userId);
      if (absence) {
        usersList[i] = {
          ...currentUser,
          declarationDate: absence.declarationDate,
          declarationDateStart: absence.declarationDateStart,
          declarationDateEnd: absence.declarationDateEnd,
          declarationStatus: absence.declarationStatus,
        };
      }
    }
    return usersList;
  }
}
