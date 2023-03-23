interface UserModel {
    user_id: number,
    user_last_name: string,
    user_first_name: string,
    user_email: string,
    user_login: string,
    user_password: string,
    team_mate_id: number | null,
    team_mate_team_id: number | null,
    team_mate_user_id: number,
    captain_id: number | null,
    captain_user_id: number,
}

export default UserModel