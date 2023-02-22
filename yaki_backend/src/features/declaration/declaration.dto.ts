import { StatusDeclaration } from "./status.enum";

interface DeclarationType {
    declaration_id: number;
    declaration_team_mate_id: number;
    declaration_date: Date;
    status: StatusDeclaration
}

export { DeclarationType }