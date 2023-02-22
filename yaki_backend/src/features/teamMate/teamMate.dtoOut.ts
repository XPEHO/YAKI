export class TeamMateDtoOut {
    team_mate_id: number
    user_id: number
    team_id: number
    last_name: string
    first_name: string
    email: string

    constructor(
        team_mate_id: number,
        user_id: number,
        team_id: number,
        last_name: string,
        first_name: string,
        email: string
    ) {
        this.team_mate_id = team_mate_id;
        this.user_id = user_id;
        this.team_id = team_id;
        this.last_name = last_name;
        this.first_name = first_name;
        this.email = email;
    }
}