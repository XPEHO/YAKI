import UserModel from "../../features/user/user.dtoIn";

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
const mockDb : UserModel[] = [
=======
const dbMockup : UserModel[] = [
>>>>>>> 8ba3596 (test(user-login): add mockup data and beginning of user service testing)
=======
const mockDb : UserModel[] = [
>>>>>>> 3dd106a (test(user-auth): add test for team mate and captain creation methods)
=======
const dbMockup : UserModel[] = [
>>>>>>> 8dbf4e1 (test(user-login): add mockup data and beginning of user service testing)
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

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
export default mockDb
=======
export default dbMockup
>>>>>>> 8ba3596 (test(user-login): add mockup data and beginning of user service testing)
=======
export default mockDb
>>>>>>> 3dd106a (test(user-auth): add test for team mate and captain creation methods)
=======
export default dbMockup
>>>>>>> 8dbf4e1 (test(user-login): add mockup data and beginning of user service testing)
