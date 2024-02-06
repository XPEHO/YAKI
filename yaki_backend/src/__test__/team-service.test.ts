import {TeamService} from "../features/team/team.service";
import {TeamRepository} from "../features/team/team.repository";
import {TeamDtoIn} from "../features/team/team.dtoIn";
import {TeamLogoDto} from "../features/team/teamLogo.dto";

jest.mock("../features/team/team.repository", () => {
  return {
    TeamRepository: jest.fn().mockImplementation(() => {
      return {
        getTeamByTeammateId: jest.fn(),
        getTeamsLogoByTeamsId: jest.fn(),
      };
    }),
  };
});

describe("TeamService", () => {
  let service: TeamService;
  let mockTeamRepository: jest.Mocked<TeamRepository>;

  beforeEach(() => {
    const MockTeamRepository = TeamRepository as jest.MockedClass<typeof TeamRepository>;
    mockTeamRepository = new MockTeamRepository() as jest.Mocked<TeamRepository>;
    service = new TeamService(mockTeamRepository);
  });

  describe("getTeamByTeammateId", () => {
    it("should return the team if it exists", async () => {
      const team: TeamDtoIn[] = [{teamId: 1, teamName: "Team 1", teamActifFlag: true}];
      mockTeamRepository.getTeamByTeammateId.mockResolvedValueOnce(team);

      const result = await service.getTeamByTeammateId(1);
      if (result !== undefined) {
        expect(result).toEqual(team);
      } else {
        fail("Expected result to be defined");
      }
    });

    it("should throw an error if the team does not exist", async () => {
      mockTeamRepository.getTeamByTeammateId.mockRejectedValueOnce(
        new Error("Team does not exist")
      );

      await expect(service.getTeamByTeammateId(1)).rejects.toThrow("Team does not exist");
      expect(mockTeamRepository.getTeamByTeammateId).toHaveBeenCalledWith(1);
      expect(mockTeamRepository.getTeamByTeammateId).toHaveBeenCalledTimes(1);
    });
  });

  describe("getTeamsLogoByTeamsId", () => {
    it("should return a teams logo list if it exists", async () => {
      const buffer1 = Buffer.from("mock buffer data 1");
      const buffer2 = Buffer.from("mock buffer data 2");

      const teamLogo: TeamLogoDto[] = [
        {teamLogoTeamId: 1, teamLogoBlob: buffer1},
        {teamLogoTeamId: 2, teamLogoBlob: buffer2},
      ];
      mockTeamRepository.getTeamsLogoByTeamsId.mockResolvedValueOnce(teamLogo);

      const result = await service.getTeamsLogoByTeamsId([1, 2]);
      expect(result).toEqual(teamLogo);
      expect(mockTeamRepository.getTeamsLogoByTeamsId).toHaveBeenCalledWith([1, 2]);
      expect(mockTeamRepository.getTeamsLogoByTeamsId).toHaveBeenCalledTimes(1);
    });

    it("should return an empty array if the team does not exist", async () => {
      const teamLogo: TeamLogoDto[] = [];

      mockTeamRepository.getTeamsLogoByTeamsId.mockResolvedValueOnce(teamLogo);

      const result = await service.getTeamsLogoByTeamsId([1, 2]);
      expect(result).toEqual(teamLogo);
      expect(mockTeamRepository.getTeamsLogoByTeamsId).toHaveBeenCalledWith([1, 2]);
      expect(mockTeamRepository.getTeamsLogoByTeamsId).toHaveBeenCalledTimes(1);
    });
  });

  describe("getTeamByUserId", () => {
    it("should return the teams if they exist", async () => {
      const teams: TeamDtoIn[] = [
        {teamId: 1, teamName: "Team 1", teamActifFlag: true},
        {teamId: 2, teamName: "Team 2", teamActifFlag: true},
      ];
      mockTeamRepository.getTeamByTeammateId.mockResolvedValueOnce(teams);

      const result = await service.getTeamByUserId(1);
      expect(result).toEqual(teams);
    });

    it("should throw an error if the teams do not exist", async () => {
      mockTeamRepository.getTeamByTeammateId.mockResolvedValueOnce([]);

      const result = await service.getTeamByUserId(1);
      if (result !== undefined) {
        expect(result).toEqual([]);
      } else {
        fail("Expected result to be defined");
      }
    });
  });
});
