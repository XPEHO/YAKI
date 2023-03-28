import { CaptainDtoIn } from '../../features/captain/captain.dtoIn';

const mockCaptain: CaptainDtoIn[] = [
  {
    captain_id: 1,
    team_mate_user_id: 1,
    user_id: 1,
    user_last_name: 'Lavigne',
    user_first_name: 'Martin',
    user_email: 'lavigne.martin@gmail.com',
    user_login: 'lavigne',
    user_password: 'lavigne',
  },
  {
    captain_id: 2,
    team_mate_user_id: 2,
    user_id: 2,
    user_last_name: 'Doe',
    user_first_name: 'John',
    user_email: 'doe.john@gmail.com',
    user_login: 'doe',
    user_password: 'doe',
  },
];

export default mockCaptain;
