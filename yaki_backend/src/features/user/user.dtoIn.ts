interface UserModel {
    user_id: number,
    user_last_name: string,
    user_first_name: string,
    user_email: string,
    user_login: string,
    user_password: string,
    team_mate_id: string,
    team_mate_team_id: string,
    team_mate_user_id: string,
    captain_id: string,
    captain_user_id: string
}

export default UserModel