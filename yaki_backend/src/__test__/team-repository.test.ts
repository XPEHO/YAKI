import {Client} from "pg";
import {TeamRepository} from "../features/team/team.repository";
import {TeamLogoDto} from "../features/team/teamLogo.dto";

jest.mock("pg", () => {
  const mClient = {
    connect: jest.fn(),
    query: jest.fn(),
    end: jest.fn(),
  };
  return {Client: jest.fn(() => mClient)};
});

describe("TeamRepository", () => {
  let teamRepository: TeamRepository;
  let pgClient: any;

  beforeEach(() => {
    teamRepository = new TeamRepository();
    pgClient = new Client();
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it("should get team logos by team ids", async () => {
    const teamIds = [1, 2, 3];
    const mockRows = [
      {team_logo_team_id: 1, team_logo_blob: Buffer.from("blob1")},
      {team_logo_team_id: 2, team_logo_blob: Buffer.from("blob2")},
      {team_logo_team_id: 3, team_logo_blob: Buffer.from("blob3")},
    ];
    pgClient.query.mockResolvedValue({rows: mockRows});

    const result = await teamRepository.getTeamsLogoByTeamsId(teamIds);

    expect(pgClient.connect).toHaveBeenCalled();
    expect(pgClient.query).toHaveBeenCalledWith(expect.stringContaining("1,2,3"));
    expect(pgClient.end).toHaveBeenCalled();
    expect(result).toEqual(
      mockRows.map((row) => new TeamLogoDto(row.team_logo_team_id, row.team_logo_blob))
    );
  });

  it("should return empty list if no team logo found", async () => {
    const teamIds = [1, 2, 3];
    pgClient.query.mockResolvedValue({rows: []});

    const result = await teamRepository.getTeamsLogoByTeamsId(teamIds);

    expect(pgClient.connect).toHaveBeenCalled();
    expect(pgClient.query).toHaveBeenCalledWith(expect.stringContaining("1,2,3"));
    expect(pgClient.end).toHaveBeenCalled();
    expect(result).toEqual([]);
  });
});
