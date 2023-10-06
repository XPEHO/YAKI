import {StatusDeclaration} from "../features/declaration/status.enum";
import {TeamRepository} from "../features/team/team.repository";
import {TeamService} from "../features/team/team.service";
import {TeammateRepository} from "../features/teammate/teammate.repository";
import {TeammateService} from "../features/teammate/teammate.service";
import {TeammateWithDeclaration} from "../features/teammate/teammateWithDeclaration.dtoOut";

// Mocked dependencies
jest.mock("../features/team/team.repository");
jest.mock("../features/teammate/teammate.repository");
jest.mock("../features/team/team.service");

describe("TeammateService testing", () => {
  // create mocked class
  let mockTeamRespository = new TeamRepository() as jest.Mocked<TeamRepository>;
  let mockTeamService = new TeamService(mockTeamRespository) as jest.Mocked<TeamService>;
  let mockTeammateRepository = new TeammateRepository() as jest.Mocked<TeammateRepository>;
  // create service to test
  let teammateService = new TeammateService(mockTeammateRepository, mockTeamService);

  it("should fetch teammates with their lastest declaration", async () => {
    // Mock the data
    const mockCaptainId: number = 12;
    const mockTeamId: number = 20;
    const mockTeammatesDataApiReponse = [
      {
        user_id: 1,
        teammate_id: 101,
        user_last_name: "Doe",
        user_first_name: "John",
        declaration_date: new Date("2023/8/20"),
        declaration_status: StatusDeclaration.REMOTE,
        team_id: 20,
        team_name: "Test team",
      },
    ];
    const mockTeamDtoApiResponse = [
      {
        teamId: 20,
        teamName: "Test team",
        teamCaptainId: mockTeamId,
        teamCustomerId: 1,
        teamActifFlag: true,
      },
    ];

    // Mock TeamService response
    mockTeamService.getTeamsByCaptainId = jest.fn().mockResolvedValue(mockTeamDtoApiResponse);
    // Mock TeammateRepository response
    mockTeammateRepository.getByTeamIdWithLastDeclaration = jest.fn().mockResolvedValue(mockTeammatesDataApiReponse);

    // method to test
    const result = await teammateService.getByTeamIdWithLastDeclaration(mockCaptainId);

    // Assertions
    expect(mockTeamService.getTeamsByCaptainId).toHaveBeenCalledWith(mockCaptainId);
    expect(mockTeammateRepository.getByTeamIdWithLastDeclaration).toHaveBeenCalledWith(mockTeamId);
    expect(result).toEqual(
      mockTeammatesDataApiReponse.map(
        (element) =>
          new TeammateWithDeclaration(
            element.user_id,
            element.teammate_id,
            element.user_last_name,
            element.user_first_name,
            element.declaration_date,
            element.declaration_status,
            element.team_id,
            element.team_name
          )
      )
    );
  });
});
