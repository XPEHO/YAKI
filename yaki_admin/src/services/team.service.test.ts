// Generated by CodiumAI

import { TeamService } from "./team.service";

describe('TeamService_class', () => {

});

    // Tests that the createTeam method of TeamService class returns a TeamType object
    it('test_createTeam_returns_TeamType_object', async () => {
        const teamService = new TeamService();
        const cptId = 1;
        const teamName = 'Team 1';

        const result = await teamService.createTeam(cptId, teamName);

        expect(result).toEqual(expect.objectContaining({
            id: expect.any(Number),
            captainId: cptId,
            teamName: teamName
        }));
    });


    // Tests that getAllTeamsWithinCaptain method returns an array of TeamType objects
    it('test_getAllTeamsWithinCaptain_returns_array', async () => {
        const teamService = new TeamService();
        const teams = await teamService.getAllTeamsWithinCaptain(1);
        expect(Array.isArray(teams)).toBe(true);
        expect(teams.length).toBeGreaterThan(0);
        expect(teams[0]).toHaveProperty('id');
        expect(teams[0]).toHaveProperty('captainId');
        expect(teams[0]).toHaveProperty('teamName');
    });
