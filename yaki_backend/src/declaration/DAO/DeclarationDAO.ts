import { StatusDeclaration } from "../enum/statusEnum";

interface Declaration {
    declaration_id: number;
    declaration_team_mate_id: number;
    declaration_date: Date;
    status: StatusDeclaration
}

export { Declaration }