import { TeamMateDtoIn } from '../../features/teamMate/teamMate.dtoIn';

const teamMatesMock: TeamMateDtoIn[] = [
  {
    team_mate_id: 1,
    team_mate_team_id: 1,
    team_mate_user_id: 1,
    user_id: 1,
    user_last_name: 'Dupuis',
    user_first_name: 'Jean',
    user_email: 'jean.dupuis@gmail.com',
    user_login: 'dupuis',
    user_password: 'dupuis',
    
  },
  {
    team_mate_id: 2,
    team_mate_team_id: 2,
    team_mate_user_id: 2,
    user_id: 2,
    user_last_name: 'Deschamps',
    user_first_name: 'Didier',
    user_email: 'didier.deschamps@gmail.com',
    user_login: 'deschamps',
    user_password: 'deschamps',
  },
];

export default teamMatesMock;
