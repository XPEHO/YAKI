import {TeammateService} from "../features/teammate/teammate.service";
import {TeammateRepository} from "../features/teammate/teammate.repository";
import mockTeammates from "./__mocks__/teammate";
import {TeamService} from "../features/team/team.service";
import {TeamRepository} from "../features/team/team.repository";
import mockTeam from "./__mocks__/team";
import mockTeammatesWithDeclaration from "./__mocks__/teammateWithDeclaration";

const mockedTeammateRepo = jest.mocked(TeammateRepository, {shallow: true});
const mockedTeamService = jest.mocked(TeamService, {shallow: true});

jest.mock("../features/teammate/teammate.repository", () => {
  return {
    TeammateRepository: jest.fn().mockImplementation(() => {
      return {
        getByTeamIdWithLastDeclaration: async (teamId: number) => {
          const teamMates = mockTeammates.filter((elm) => elm.teammate_team_id == teamId);
          const teamMateWithDeclaration = mockTeammatesWithDeclaration.filter(
            (elm) => elm.team_mate_id == teamMates[0].teammate_id
          );
          return teamMateWithDeclaration;
        },
      };
    }),
  };
});

jest.mock("../features/team/team.service", () => {
  return {
    TeamService: jest.fn().mockImplementation(() => {
      return {
        getTeamByCaptainId: async (captain_id: number) => {
          const team = mockTeam.filter((elm) => elm.teamCaptainId == captain_id);
          return team[0];
        },
      };
    }),
  };
});

describe("get teammate by team id with last declaration", () => {
  const teamRepo = new TeamRepository();
  const teamService = new TeamService(teamRepo);
  const teammateRepo = new TeammateRepository();
  const teammateService = new TeammateService(teammateRepo, teamService);
  beforeEach(() => {
    mockedTeamService.mockClear();
    mockedTeammateRepo.mockClear();
  });

  it("return a teammate with last declaration", async () => {
    expect(await teammateService.getByTeamIdWithLastDeclaration(1)).toMatchObject([
      {
        userId: 1,
        userLastName: "Dupuis",
        userFirstName: "Jean",
        declarationDate: new Date("1996-12-23"),
        declarationStatus: "on site",
      },
    ]);
  });
});
