import {TeamMateService} from "../features/teamMate/teamMate.service";
import {TeamMateRepository} from "../features/teamMate/teamMate.repository";
import mockTeamMates from "./__mocks__/teamMate";
import {TeamMateDtoIn} from "../features/teamMate/teamMate.dtoIn";
import {TeamService} from "../features/team/team.service";
import {TeamRepository} from "../features/team/team.repository";
import mockTeam from "./__mocks__/team";
import mockTeamMatesWithDeclaration from "./__mocks__/teamMateWithDeclaration";

const mockedTeamMateRepo = jest.mocked(TeamMateRepository, {shallow: true});
const mockedTeamService = jest.mocked(TeamService, {shallow: true});

jest.mock("../features/teamMate/teamMate.repository", () => {
  return {
    TeamMateRepository: jest.fn().mockImplementation(() => {
      return {
        getByUserId: (user_id: number): TeamMateDtoIn => {
          const user = mockTeamMates.filter((elm) => elm.user_id == user_id);
          if (user_id == null) {
            throw new Error("Bad authentification details");
          }
          return user[0];
        },
        getByTeamIdWithLastDeclaration: async (teamId: number) => {
          const teamMates = mockTeamMates.filter((elm) => elm.teammate_team_id == teamId);
          const teamMateWithDeclaration = mockTeamMatesWithDeclaration.filter(
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

describe("get teammate by userId", () => {
  const teamRepo = new TeamRepository();
  const teamService = new TeamService(teamRepo);
  const teamMateRepo = new TeamMateRepository();
  const teamMateService = new TeamMateService(teamMateRepo, teamService);
  beforeEach(() => {
    mockedTeamMateRepo.mockClear();
  });
  it("return a team mate", async () => {
    expect(await teamMateService.getByUserId("1")).toMatchObject({
      user_id: 1,
    });
  });
});

describe("get teammate by team id with last declaration", () => {
  const teamRepo = new TeamRepository();
  const teamService = new TeamService(teamRepo);
  const teamMateRepo = new TeamMateRepository();
  const teamMateService = new TeamMateService(teamMateRepo, teamService);
  beforeEach(() => {
    mockedTeamService.mockClear();
    mockedTeamMateRepo.mockClear();
  });

  it("return a team mate with last declaration", async () => {
    expect(await teamMateService.getByTeamIdWithLastDeclaration(1)).toMatchObject([
      {
        userId: 1,
        teamMateId: 1,
        userLastName: "Dupuis",
        userFirstName: "Jean",
        declarationDate: new Date("1996-12-23"),
        declarationStatus: "on site",
      },
    ]);
  });
});
