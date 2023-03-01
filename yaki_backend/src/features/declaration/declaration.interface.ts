import { StatusDeclaration } from "./status.enum";

/* Defining the interface for the declaration object. */
export interface Declaration {
    declaration_id: number;
    declaration_team_mate_id: number;
    declaration_date: Date;
    declaration_status: StatusDeclaration
}