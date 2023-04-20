import { TeamRepository } from "../features/team/team.repository";
import { TeamService } from "../features/team/team.service";
// import mockTeam from "./__mocks__/team";

describe('teamService', () => {
    let teamService: TeamService;
    let teamRepository: TeamRepository;

   

    beforeEach(() => {
        teamRepository = new TeamRepository();
        teamService = new TeamService(teamRepository);
    });

    describe('getTeamByTeamMateId', () => {
        const mockTeamMateId = 1;
        const mockTeam = [
            {
                "team_mate_id": 3,
                "team_mate_team_id": 2,
                "team_mate_user_id": 3,
                "team_id": 2,
                "team_captain_id": 2,
                "team_name": "Equipe 2"
            }
        ];

        it('should return a team', async () => {
            jest.spyOn(teamRepository, 'getTeamByTeamMateId').mockResolvedValueOnce([
                {
                    "team_mate_id": 3,
                    "team_mate_team_id": 2,
                    "team_mate_user_id": 3,
                    "team_id": 2,
                    "team_captain_id": 2,
                    "team_name": "Equipe 2"
                }
            ]);
            const getTeam = await teamService.getTeamByTeamMateId(mockTeamMateId);
            
            console.log(getTeam);
            console.log(mockTeam);

            expect(getTeam).toEqual(mockTeam);
        });
    } 
    );
}
);
