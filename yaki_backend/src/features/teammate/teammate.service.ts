import {AvatarService} from "./../user_avatar/avatar.service";
import {UserWithDeclaration} from "./userWithDeclaration.dtoOut";
import {TeammateRepository} from "./teammate.repository";
import {TeamService} from "../team/team.service";
import {AbsenceDeclarationDto} from "./absenceDeclaration.dto";
import {UserWithDeclarationDepreciated} from "./userWithDeclarationDepreciated.dto";
import {TeamDtoIn} from "../team/team.dtoIn";
import {AvatarDto} from "../user_avatar/avatar.dto";
import {
  UsersWithDeclarationAndAvatar,
  UsersWithDeclarationAndAvatarInterface,
} from "./userWithDeclarationAndAvatar.dtoOut";

export class TeammateService {
  teammateRepository: TeammateRepository;
  teamService: TeamService;
  avatarService: AvatarService;

  constructor(repository: TeammateRepository, teamServive: TeamService, avatarService: AvatarService) {
    this.teammateRepository = repository;
    this.teamService = teamServive;
    this.avatarService = avatarService;
  }

  /**
   * Will retrive all teammates's declarations from the same team as the selected user.
   * - 1 Get all users id of teammates being in the same team as the selected user.
   * - 2 Get each user's declarations given the previewsly obtain users id list.
   * - 3 If one of more user(s) from the list has no declaration, check if this/thoses users have an absence.
   * - 4 Otherwise the userWithDeclaration object is unchanged. Leading to a undeclared user.
   * - 5 Get all avatars from the users id list and add them to the corresponding userWithDeclaration object.
   * @param userId the userId of the user who wants to see his teammates declarations
   * @returns List of UsersWithDeclarationAndAvatar
   */
  getTeammatesDeclarationsWithAvatarFromUserTeams = async (
    userId: number
  ): Promise<UsersWithDeclarationAndAvatar[]> => {
    if (!userId && typeof userId !== "number") {
      throw TypeError("No user id or incorrect id");
    }

    const usersIdList = await this.teammateRepository.getUsersIdFromTeamsWhereUserIsInto(userId);
    const usersWithDeclarations: UserWithDeclaration[] =
      await this.teammateRepository.getTeammatesDeclarationsFromUserTeams(usersIdList);

    try {
      const usersDeclarationAndAbsences: UserWithDeclaration[] = await this.ifAbsenceInsertData(usersWithDeclarations);

      const usersAvatar: AvatarDto[] | null = await this.avatarService.getAvatarsByUsersId(usersIdList);
      const usersWithDeclarationAndAvatar = this.addAvatarChoiceToUserWithDeclaration(
        usersDeclarationAndAbsences,
        usersAvatar!
      );

      return usersWithDeclarationAndAvatar;
    } catch (error: any) {
      console.error(error.message);
      throw error;
    }
  };

  /**
   * If one of more user(s) from the list has no declaration, check if this/thoses users have an absence.
   * If yes, insert absence data (dates and status) into the corresponding userWitherDeclaration object.
   * Otherwise the userWithDeclaration object is unchanged. Leading to a undeclared user.
   * @param usersList the list of users with their declaration ( or lack of declaration)
   * @returns UserWithDeclaration[]
   */
  async ifAbsenceInsertData(usersList: UserWithDeclaration[]): Promise<UserWithDeclaration[]> {
    const hasUndeclaredUsers: UserWithDeclaration[] = usersList.filter(
      (user) => user.declarationStatus == null && user.declarationDate == null
    );
    //exit if all users have a declaration
    if (hasUndeclaredUsers.length === 0) return usersList;

    const undeclaredUsersId: number[] = hasUndeclaredUsers.map((user) => user.userId);
    const usersAbsence: AbsenceDeclarationDto[] | null = await this.teammateRepository.getUsersAbsence(
      undeclaredUsersId
    );
    // users without declaration don't necessarily have an absence
    if (!usersAbsence) return usersList;

    const usersAbsenceMap = new Map(usersAbsence.map((absence) => [absence.declarationUserId, absence]));
    const userDeclarationAbsences = usersList.map((currentUser) => {
      if (usersAbsenceMap.has(currentUser.userId)) {
        const absence = usersAbsenceMap.get(currentUser.userId)!;
        currentUser.declarationDate = absence.declarationDate;
        currentUser.declarationDateStart = absence.declarationDateStart;
        currentUser.declarationDateEnd = absence.declarationDateEnd;
        currentUser.declarationStatus = absence.declarationStatus;
      }
      return currentUser;
    });
    return userDeclarationAbsences;
  }

  /**
   * This function adds avatar choice to each user with a declaration object.
   * If a user doesn't have an avatar, the avatars (image and reference ) fields will be null.
   * @param userWithDeclaration
   * @param usersAvatarChoices
   * @returns  UsersWithDeclarationAndAvatar[]
   */
  addAvatarChoiceToUserWithDeclaration = async (
    userWithDeclaration: UserWithDeclaration[],
    usersAvatarChoices: AvatarDto[]
  ): Promise<UsersWithDeclarationAndAvatar[]> => {
    const userAvatarMap =
      usersAvatarChoices !== null ? new Map(usersAvatarChoices!.map((avatar) => [avatar.avatarUserId, avatar])) : null;

    let usersWithDeclarationAndAvatar: UsersWithDeclarationAndAvatar[] = [];
    for (const user of userWithDeclaration) {
      const userAndAvatar: UsersWithDeclarationAndAvatarInterface = {
        ...user,
        avatarReference: null,
        avatarByteArray: null,
      };
      // add avatar once for haldDay declaration
      const isUserInArray = usersWithDeclarationAndAvatar.some((userAndAvatar) => userAndAvatar.userId === user.userId);
      if (isUserInArray) {
        usersWithDeclarationAndAvatar.push(userAndAvatar);
        continue;
      }
      if (userAvatarMap && userAvatarMap.has(user.userId)) {
        const avatarInfo = userAvatarMap.get(user.userId)!;

        userAndAvatar.avatarReference = avatarInfo.avatarReference;
        userAndAvatar.avatarByteArray = avatarInfo.avatarBlob ? Array.from(avatarInfo.avatarBlob) : null;
      }
      usersWithDeclarationAndAvatar.push(userAndAvatar);
    }
    return usersWithDeclarationAndAvatar;
  };

  // DEPRECIATED - TO BE REMOVED WHEN 1.15.0 isnt used anymore
  //=====================================================================================================================
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

    try {
      const usersWithDeclarations: UserWithDeclaration[] =
        await this.teammateRepository.getTeammatesDeclarationsFromUserTeams(usersIdList);

      return await this.ifAbsenceInsertData(usersWithDeclarations);
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  };

  // DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
  //=====================================================================================================================
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
  //=====================================================================================================================
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
}
