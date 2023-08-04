import {TeammateRepository} from "../features/teammate/teamate.repository";
import {TeammateService} from "../features/teammate/teamate.service";
import {TeamService} from "../features/team/team.service";
import {TeamRepository} from "../features/team/team.repository";
import teamMock from "./__mocks__/team";
import teammatesMock from "./__mocks__/teammate";
import mockTeammatesWithDeclaration from "./__mocks__/mockTeammatesWithDeclaration";

const mockTeammateRepo = jest.mocked(TeammateRepository, {shallow: true});
const mockTeamService = jest.mocked(TeamService, {shallow: true});

jest.mock("../features/team/team.repository", () => {
  // mock the team repository to use the mock team data
  return {
    TeamRepository: jest.fn().mockImplementation(() => {
      // mock the team repository to use the mock team data
      return {
        getTeamByCaptainId: async (captain_id: number) => {
          const team = teamMock.filter((elm) => elm.teamCaptainId == captain_id);
          return team;
        },
      };
    }),
  };
});

jest.mock("../features/teammate/teammate.repository", () => {
  return {
    TeammateRepository: jest.fn().mockImplementation(() => {
      return {
        getByTeamIdWithLastDeclaration: async (teamId: number) => {
          // just to use teamId, this is the "preview DB review way, as now declaration arent bound anymore to teammate_id"
          //Get teamates from mock [] where there teamID = teamID to get teammates with their declarations
          const teammates = teammatesMock.filter((teammate) => teammate.teammate_team_id == teamId);
          // filter the "teammate with declarations" corresponding to the user being in the selected team from their teammate-id
          const teammateWithDeclaration = mockTeammatesWithDeclaration.filter(
            (userWithDecla) => userWithDecla.teammate_id == teammates[0].teammate_id
          );
          return teammateWithDeclaration;
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
          const team = teamMock.filter((elm) => elm.teamCaptainId == captain_id);
          return team;
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
    mockTeamService.mockClear();
    mockTeammateRepo.mockClear();
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
