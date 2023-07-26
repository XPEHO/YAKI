import {TeammateService} from "../features/teammate/teammate.service";
import {TeammateRepository} from "../features/teammate/teammate.repository";
import {TeamService} from "../features/team/team.service";
import {TeamRepository} from "../features/team/team.repository";
import mockTeam from "./__mocks__/mockTeam";
import mockTeammates from "./__mocks__/mockTeammate";
import mockTeammatesWithDeclaration from "./__mocks__/mockTeammatesWithDeclaration";

const mockedTeammateRepo = jest.mocked(TeammateRepository, {shallow: true});
const mockedTeamService = jest.mocked(TeamService, {shallow: true});

jest.mock("../features/teammate/teammate.repository", () => {
  return {
    TeammateRepository: jest.fn().mockImplementation(() => {
      return {
        getByTeamIdWithLastDeclaration: async (teamId: number) => {
          // just to use teamId, this is the "preview DB review way, as now declaration arent bound anymore to teammate_id"
          //Get teamates from mock [] where there teamID = teamID to get teammates with their declarations
          const teammates = mockTeammates.filter((teammate) => teammate.teammate_team_id == teamId);
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
          const team = mockTeam.filter((elm) => elm.teamCaptainId == captain_id);
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
