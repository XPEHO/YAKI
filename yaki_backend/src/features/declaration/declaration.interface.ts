import { StatusDeclaration } from "./status.enum";

export interface Declaration {
    declaration_id: number;
    declaration_team_mate_id: number;
    declaration_date: Date;
    status: StatusDeclaration
}