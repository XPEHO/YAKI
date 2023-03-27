import { TeamMateService } from '../features/teamMate/teamMate.service';
import { TeamMateRepository } from '../features/teamMate/teamMate.repository';
import mockTeamMates from './__mocks__/teamMate';
import { TeamMateDtoIn } from '../features/teamMate/teamMate.dtoIn';
import { TeamService } from '../features/team/team.service';
import { TeamRepository } from '../features/team/team.repository';
import mockTeam from './__mocks__/team';
import mockTeamMatesWithDeclaration from './__mocks__/teamMateWithDeclaration';

const mockedTeamMateRepo = jest.mocked(TeamMateRepository, { shallow: true });
const mockedTeamRepo = jest.mocked(TeamRepository, { shallow: true });

jest.mock('../features/teamMate/teamMate.repository', () => {
  return {
    TeamMateRepository: jest.fn().mockImplementation(() => {
      return {
        getByUserId: (user_id: number): TeamMateDtoIn => {
          const user = mockTeamMates.filter((elm) => elm.user_id == user_id);
          if (user_id == null) {
            throw new Error('Bad authentification details');
          }
          return user[0];
        },
        getByTeamIdWithLastDeclaration: async (team_id: number) => {
          const teamMates = await mockTeamMates.filter(
            (elm) => elm.team_mate_team_id == team_id
          );
          const teamMateWithDeclaration =
            await mockTeamMatesWithDeclaration.filter(
              (elm) => elm.team_mate_id == teamMates[0].team_mate_id
            );
          return teamMateWithDeclaration;
        },
      };
    }),
  };
});

jest.mock('../features/team/team.repository', () => {
  return {
    TeamRepository: jest.fn().mockImplementation(() => {
      return {
        getByCaptainId: async (captain_id: number) => {
          const team = await mockTeam.filter(
            (elm) => elm.team_captain_id == captain_id
          );
          return team[0];
        },
      };
    }),
  };
});

describe('get teammate by userId', () => {
  const teamRepo = new TeamRepository();
  const teamService = new TeamService(teamRepo);
  const teamMateRepo = new TeamMateRepository();
  const teamMateService = new TeamMateService(teamMateRepo, teamService);
  beforeEach(() => {
    mockedTeamMateRepo.mockClear();
  });
  it('return a team mate', async () => {
    expect(await teamMateService.getByUserId('1')).toMatchObject({
      user_id: 1,
    });
  });
});

describe('get teammate by team id with last declaration', () => {
  const teamRepo = new TeamRepository();
  const teamService = new TeamService(teamRepo);
  const teamMateRepo = new TeamMateRepository();
  const teamMateService = new TeamMateService(teamMateRepo, teamService);
  beforeEach(() => {
    mockedTeamRepo.mockClear();
    mockedTeamMateRepo.mockClear();
  });

  it('return a team mate with last declaration', async () => {
    expect(
      await teamMateService.getByTeamIdWithLastDeclaration(1)
    ).toMatchObject([
      {
        userId: 1,
        teamMateId: 1,
        userLastName: 'Dupuis',
        userFirstName: 'Jean',
        declarationDate: new Date('1996-12-23'),
        declarationStatus: 'On site',
      },
    ]);
  });
});
