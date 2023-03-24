import { TeamMateService } from '../features/teamMate/teamMate.service';
import { TeamMateRepository } from '../features/teamMate/teamMate.repository';
import mockTeamMock from './__mocks__/teamMate';
import TeamMateDtoIn from '../features/teamMate/teamMate.dtoIn';
import { TeamService } from '../features/team/team.service';
import { TeamRepository } from '../features/team/team.repository';

const mockedTeamMateRepo = jest.mocked(TeamMateRepository, { shallow: true });

jest.mock('../features/teamMate/teamMate.repository', () => {
  return {
    TeamMateRepository: jest.fn().mockImplementation(() => {
      return {
        getByUserId: (user_id: number): TeamMateDtoIn => {
          const user = mockTeamMock.filter((elm) => elm.user_id == user_id);
          if (user_id == null) {
            throw new Error('Bad authentification details');
          }
          return user[0];
        },
      };
    }),
  };
});

describe('get teammate by userId', () => {
  const teamMateRepo = new TeamMateRepository();
  const teamMateService = new TeamMateService(
    teamMateRepo,
    new TeamService(new TeamRepository())
  );
  beforeEach(() => {
    mockedTeamMateRepo.mockClear();
  });
  it('return a team mate', async () => {
    expect(await teamMateService.getByUserId('1')).toMatchObject({
      user_id: 1,
    });
  });
});
