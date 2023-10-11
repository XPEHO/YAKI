import {TeamService} from "./../features/team/team.service";
import {StatusDeclaration} from "../features/declaration/status.enum";
import {TeammateRepository} from "../features/teammate/teammate.repository";
import {TeammateService} from "../features/teammate/teammate.service";
import {UserWithDeclaration} from "../features/teammate/userWithDeclaration.dtoOut";
import {TeamRepository} from "../features/team/team.repository";
import {TeamDtoIn} from "../features/team/team.dtoIn";

const mockUserId = 1;

const mockTeam: TeamDtoIn[] = [
  {
    teamId: 1,
    teamName: "Team A",
    teamActifFlag: true,
  },
  {
    teamId: 2,
    teamName: "Team B",
    teamActifFlag: true,
  },
];

const mockTeammates = [
  {
    user_id: 1,
    user_last_name: "Doe",
    user_first_name: "John",
    declaration_date: new Date("2023/8/20"),
    declaration_status: StatusDeclaration.REMOTE,
    team_id: 3,
    team_name: "Team A",
    declaration_date_start: new Date("2023/8/20"),
    declaration_date_end: new Date("2023/8/20"),
    declaration_id: 1,
    declaration_user_id: 1,
  },
  {
    user_id: 1,
    user_last_name: "Doe",
    user_first_name: "John",
    declaration_date: new Date("2023/8/20"),
    declaration_status: StatusDeclaration.REMOTE,
    team_id: 2,
    team_name: "Team A",
    declaration_date_start: new Date("2023/8/20"),
    declaration_date_end: new Date("2023/8/20"),
    declaration_id: 2,
    declaration_user_id: 1,
  },
];
const mockResult = [
  new UserWithDeclaration(
    1,
    "Doe",
    "John",
    new Date("2023/8/20"),
    StatusDeclaration.REMOTE,
    3,
    "Team A",
    new Date("2023/8/20"),
    new Date("2023/8/20"),
    1,
    1
  ),
  new UserWithDeclaration(
    1,
    "Doe",
    "John",
    new Date("2023/8/20"),
    StatusDeclaration.REMOTE,
    2,
    "Team A",
    new Date("2023/8/20"),
    new Date("2023/8/20"),
    2,
    1
  ),
];

// Mock of TeammateRepository
jest.mock("../features/teammate/teammate.repository", () => {
  return {
    TeammateRepository: jest.fn().mockImplementation(() => {
      return {
        getByTeamIdWithLastDeclaration: (teamsIdList: number[]): any[] => {
          // return a mock array of teammates
          if (teamsIdList[0] === 1) {
            return mockTeammates;
          }
          return mockTeammates;
        },
      };
    }),
  };
});

// Mock of TeamService
jest.mock("./../features/team/team.service", () => {
  return {
    TeamService: jest.fn().mockImplementation(() => {
      return {
        getTeamByUserId: (userId: number): any[] => {
          if (userId === mockUserId) {
            return mockTeam;
          }
          // return a mock array of teams
          return mockTeam;
        },
      };
    }),
  };
});

describe("getByTeamIdWithLastDeclaration", () => {
  // Initialize teammateService, teammateRepository and teamService
  const teamRepo = new TeamRepository();
  const teammateRepo = new TeammateRepository();
  const teamService = new TeamService(teamRepo);
  const teammateService = new TeammateService(teammateRepo, teamService);

  it("should return an array of UserWithDeclaration objects", async () => {
    const result = await teammateService.getByTeamIdWithLastDeclaration(1);
    expect(result).toEqual(mockResult);
  });
});
