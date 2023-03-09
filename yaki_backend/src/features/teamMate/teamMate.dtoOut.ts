export class TeamMateDtoOut {
    teamMateId: number
    userId: number
    teamId: number
    lastName: string
    firstName: string
    email: string
    token: string | undefined = undefined;

    constructor(
        team_mate_id: number,
        user_id: number,
        team_id: number,
        last_name: string,
        first_name: string,
        email: string
    ) {
        this.teamMateId = team_mate_id;
        this.userId = user_id;
        this.teamId = team_id;
        this.lastName = last_name;
        this.firstName = first_name;
        this.email = email;
    }
}