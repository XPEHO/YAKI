import { StatusDeclaration } from '../features/declaration/status.enum';
import { TeamRepository } from '../features/team/team.repository';
import { TeamService } from '../features/team/team.service';
import { TeammateRepository } from '../features/teammate/teammate.repository';
import { TeammateService } from '../features/teammate/teammate.service';
import { TeammateWithDeclaration } from '../features/teammate/teammateWithDeclaration.dtoOut';

// Mocked dependencies
jest.mock('../features/team/team.repository');
jest.mock('../features/teammate/teammate.repository');
jest.mock('../features/team/team.service');
jest.mock('../features/teammate/teammate.service');

describe('TeammateService testing', () => {
  // create mocked classes
  let mockTeamRespository = new TeamRepository() as jest.Mocked<TeamRepository>;
  let mockTeamService = new TeamService(
    mockTeamRespository
  ) as jest.Mocked<TeamService>;
  let mockTeammateRepository =
    new TeammateRepository() as jest.Mocked<TeammateRepository>;
  let mockTeammateService = new TeammateService(
    mockTeammateRepository,
    mockTeamService
  ) as jest.Mocked<TeammateService>;

  it('should fetch teammates with their latest declaration', async () => {
    // Mock the data
    const mockCaptainId: number = 1;
    const mockTeammatesDataApiResponse = [
      {
        user_id: 1,
        teammate_id: 101,
        user_last_name: 'Doe',
        user_first_name: 'John',
        declaration_date: new Date('2023/8/20'),
        declaration_status: StatusDeclaration.REMOTE,
        team_id: 20,
        team_name: 'Test team',
      },
    ];
    const mockTeamDtoApiResponse = [
      {
        teamId: 20,
        teamName: 'Test team',
        teamCaptainId: 1,
        teamCustomerId: 1,
        teamActifFlag: true,
      },
    ];

    // Mock the TeamService method
    mockTeamService.getTeamsByCaptainId.mockResolvedValue(
      mockTeamDtoApiResponse
    );

    // Mock the TeammateRepository method
    mockTeammateRepository.getByTeamIdWithLastDeclaration.mockResolvedValue(
      mockTeammatesDataApiResponse
    );

    // Call the method being tested
    const result = await mockTeammateService.getByTeamIdWithLastDeclaration(
      mockCaptainId
    );

    // Assert the result
    expect(Array.isArray(result)).toBe(true);
    expect(result.length).toBeGreaterThan(0);
    expect(result[0]).toBeInstanceOf(TeammateWithDeclaration);
  });
});
