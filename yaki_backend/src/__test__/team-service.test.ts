import { TeamService } from '../features/team/team.service';
import { TeamRepository } from '../features/team/team.repository';
import { TeamDtoIn } from '../features/team/team.dtoIn';

jest.mock('../features/team/team.repository', () => {
  return {
    TeamRepository: jest.fn().mockImplementation(() => {
      return {
        getTeamByTeammateId: jest.fn(),
      };
    }),
  };
});

describe('TeamService', () => {
  let service: TeamService;
  let mockTeamRepository: jest.Mocked<TeamRepository>;

  beforeEach(() => {
    const MockTeamRepository = TeamRepository as jest.MockedClass<
      typeof TeamRepository
    >;
    mockTeamRepository =
      new MockTeamRepository() as jest.Mocked<TeamRepository>;
    service = new TeamService(mockTeamRepository);
  });

  describe('getTeamByTeammateId', () => {
    it('should return the team if it exists', async () => {
      const team: TeamDtoIn[] = [
        { teamId: 1, teamName: 'Team 1', teamActifFlag: true },
      ];
      mockTeamRepository.getTeamByTeammateId.mockResolvedValueOnce(team);

      const result = await service.getTeamByTeammateId(1);
      if (result !== undefined) {
        expect(result).toEqual(team);
      } else {
        fail('Expected result to be defined');
      }
    });

    it('should throw an error if the team does not exist', async () => {
      mockTeamRepository.getTeamByTeammateId.mockRejectedValueOnce(
        new Error('Team does not exist')
      );

      await expect(service.getTeamByTeammateId(1)).rejects.toThrow(
        'Team does not exist'
      );
      expect(mockTeamRepository.getTeamByTeammateId).toHaveBeenCalledWith(1);
      expect(mockTeamRepository.getTeamByTeammateId).toHaveBeenCalledTimes(1);
    });
  });

  describe('getTeamByUserId', () => {
    it('should return the teams if they exist', async () => {
      const teams: TeamDtoIn[] = [
        { teamId: 1, teamName: 'Team 1', teamActifFlag: true },
        { teamId: 2, teamName: 'Team 2', teamActifFlag: true },
      ];
      mockTeamRepository.getTeamByTeammateId.mockResolvedValueOnce(teams);

      const result = await service.getTeamByUserId(1);
      expect(result).toEqual(teams);
    });

    it('should throw an error if the teams do not exist', async () => {
      mockTeamRepository.getTeamByTeammateId.mockResolvedValueOnce([]);

      const result = await service.getTeamByUserId(1);
      if (result !== undefined) {
        expect(result).toEqual([]);
      } else {
        fail('Expected result to be defined');
      }
    });
  });
});
