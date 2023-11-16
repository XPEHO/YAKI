import { TeamService } from './../features/team/team.service';
import { StatusDeclaration } from '../features/declaration/status.enum';
import { TeammateRepository } from '../features/teammate/teammate.repository';
import { TeammateService } from '../features/teammate/teammate.service';
import { TeamDtoIn } from '../features/team/team.dtoIn';
import { UserWithDeclarationDepreciated } from '../features/teammate/userWithDeclarationDepreciated.dto';
import { AvatarService } from '../features/user_avatar/avatar.service';

describe('TeammateService', () => {
  let teammateService: TeammateService;
  let teammateRepository: jest.Mocked<TeammateRepository>;
  let teamService: jest.Mocked<TeamService>;
  let avatarService: jest.Mocked<AvatarService>;

  beforeEach(() => {
    teammateRepository = {
      getByTeamIdWithLastDeclaration: jest.fn(),
    } as unknown as jest.Mocked<TeammateRepository>;

    teamService = {
      getTeamByUserId: jest.fn(),
    } as unknown as jest.Mocked<TeamService>;

    avatarService = {
      getAvatarsByUsersId: jest.fn(),
    } as unknown as jest.Mocked<AvatarService>;

    teammateService = new TeammateService(
      teammateRepository,
      teamService,
      avatarService
    );
  });

  describe('getByTeamIdWithLastDeclaration', () => {
    it('should return an empty array if the user is not in any team', async () => {
      // Arrange
      const userId = 1;
      teamService.getTeamByUserId.mockResolvedValue([]);
      // Act
      const result = await teammateService.getByTeamIdWithLastDeclaration(
        userId
      );
      // Assert
      expect(result).toEqual([]);
      expect(teamService.getTeamByUserId).toHaveBeenCalledWith(userId);
      expect(
        teammateRepository.getByTeamIdWithLastDeclaration
      ).not.toHaveBeenCalled();
    });
    it('should return the latest declaration for each teammate in the user teams', async () => {
      const ToDayDate = new Date();
      console.log(
        new Date(
          ToDayDate.getFullYear(),
          ToDayDate.getMonth(),
          ToDayDate.getDate(),
          7,
          30
        )
      );
      // Arrange
      const userId = 1;
      const teamDtoInList: TeamDtoIn[] = [
        { teamId: 1, teamName: 'Team 1', teamActifFlag: true },
        { teamId: 2, teamName: 'Team 2', teamActifFlag: true },
      ];
      const teammates = [
        {
          user_id: 1,
          user_last_name: 'Doe',
          user_first_name: 'John',
          declaration_date: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            0,
            0.0
          ),
          declaration_status: StatusDeclaration.REMOTE,
          team_id: 1,
          team_name: 'Team 1',
          declaration_date_start: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            30,
            0.0
          ),
          declaration_date_end: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            23,
            30,
            0.0
          ),
          declaration_id: 2,
          declaration_user_id: 1,
        },
        {
          user_id: 1,
          user_last_name: 'Doe',
          user_first_name: 'John',
          declaration_date: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            0,
            0.0
          ),
          declaration_status: StatusDeclaration.REMOTE,
          team_id: 1,
          team_name: 'Team 1',
          declaration_date_start: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            0,
            0.0
          ),
          declaration_date_end: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            23,
            0,
            0.0
          ),
          declaration_id: 1,
          declaration_user_id: 1,
        },
        {
          user_id: 2,
          user_last_name: 'Doe',
          user_first_name: 'Jane',
          declaration_date: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            0,
            0.0
          ),
          declaration_status: StatusDeclaration.REMOTE,
          team_id: 2,
          team_name: 'Team 2',
          declaration_date_start: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            30,
            0.0
          ),
          declaration_date_end: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            23,
            30,
            0.0
          ),
          declaration_id: 4,
          declaration_user_id: 2,
        },
        {
          user_id: 2,
          user_last_name: 'Doe',
          user_first_name: 'Jane',
          declaration_date: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            0,
            0.0
          ),
          declaration_status: StatusDeclaration.REMOTE,
          team_id: 1,
          team_name: 'Team 1',
          declaration_date_start: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            0,
            0.0
          ),
          declaration_date_end: new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            23,
            0,
            0.0
          ),
          declaration_id: 3,
          declaration_user_id: 2,
        },
      ];
      teamService.getTeamByUserId.mockResolvedValue(teamDtoInList);
      teammateRepository.getByTeamIdWithLastDeclaration.mockResolvedValue(
        teammates
      );
      // Act
      const result = await teammateService.getByTeamIdWithLastDeclaration(
        userId
      );
      // Assert
      console.log(userId);
      console.log(result);
      expect(result).toEqual([
        new UserWithDeclarationDepreciated(
          1,
          'Doe',
          'John',
          new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            0,
            0.0
          ),
          StatusDeclaration.REMOTE,
          1,
          'Team 1',
          new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            30,
            0.0
          ),
          new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            23,
            30,
            0.0
          ),
          2,
          1
        ),
        new UserWithDeclarationDepreciated(
          2,
          'Doe',
          'Jane',
          new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            0,
            0.0
          ),
          StatusDeclaration.REMOTE,
          2,
          'Team 2',
          new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            3,
            30,
            0.0
          ),
          new Date(
            ToDayDate.getFullYear(),
            ToDayDate.getMonth(),
            ToDayDate.getDate(),
            23,
            30,
            0.0
          ),
          4,
          2
        ),
      ]);
      expect(teamService.getTeamByUserId).toHaveBeenCalledWith(userId);
      expect(
        teammateRepository.getByTeamIdWithLastDeclaration
      ).toHaveBeenCalledWith([1, 2]);
    });
  });
});
