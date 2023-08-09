import {StatusDeclaration} from "../../features/declaration/status.enum";

const mockTeammatesWithDeclaration: any[] = [
  {
    user_id: 1,
    teammate_id: 1,
    user_last_name: "Dupuis",
    user_first_name: "Jean",
    declaration_date: new Date("1996-12-23"),
    declaration_status: StatusDeclaration.ON_SITE,
  },
];

export default mockTeammatesWithDeclaration;
