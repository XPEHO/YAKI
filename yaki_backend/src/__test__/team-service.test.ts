import {TeamRepository} from "../features/team/team.repository";
import {TeamService} from "../features/team/team.service";

describe("teamService", () => {
  let teamService: TeamService;
  let teamRepository: TeamRepository;

  beforeEach(() => {
    teamRepository = new TeamRepository();
    teamService = new TeamService(teamRepository);
  });

  /**
   * This function tests the getByCaptainId function in the teamService class
   */
  describe("getTeamByUserId", () => {
    const mockUserId = 1;
    const mockTeam = [
      {
        teamId: 2,
        teamName: "Equipe 2",
        teamActifFlag: true,
      },
    ];

    it("should return a team", async () => {
      jest.spyOn(teamRepository, "getTeamByTeammateId").mockResolvedValueOnce([
        {
          teamId: 2,
          teamName: "Equipe 2",
          teamActifFlag: true,
        },
      ]);
      const getTeam = await teamService.getTeamByTeammateId(mockUserId);

      expect(getTeam).toEqual(mockTeam);
    });
  });
});
