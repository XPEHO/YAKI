import UserModel from "../../features/user/user.dtoIn";

const mockDb : UserModel[] = [
  { 
    user_id: 1,
    user_last_name: 'Dugrand',
    user_first_name: 'Jacques',
    user_email: 'dugrand.jacques@mail.com',
    user_login: 'dugrand',
    user_password: 'dugrand',
    team_mate_id: 1,
    team_mate_team_id: 1,
    team_mate_user_id: 1,
    captain_id: null,
    captain_user_id: 1
  },
  { 
    user_id: 2,
    user_last_name: 'Lavigne',
    user_first_name: 'Valentin',
    user_email: 'lavigne.valentin@mail.com',
    user_login: 'lavigne',
    user_password: 'lavigne',
    team_mate_id: null,
    team_mate_team_id: null,
    team_mate_user_id: 2,
    captain_id: 1,
    captain_user_id: 2
  }
]

export default mockDb
