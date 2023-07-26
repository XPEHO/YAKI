import {TeammateDtoIn} from "../../features/teammate/teamate.dtoIn";

const teammatesMock: TeammateDtoIn[] = [
  {
    teammate_id: 1,
    teammate_team_id: 1,
    teammate_user_id: 1,
    user_id: 1,
    user_last_name: "Dupuis",
    user_first_name: "Jean",
    user_email: "jean.dupuis@gmail.com",
    user_login: "dupuis",
    user_password: "dupuis",
  },
  {
    teammate_id: 2,
    teammate_team_id: 2,
    teammate_user_id: 2,
    user_id: 2,
    user_last_name: "Deschamps",
    user_first_name: "Didier",
    user_email: "didier.deschamps@gmail.com",
    user_login: "deschamps",
    user_password: "deschamps",
  },
];

export default teammatesMock;
