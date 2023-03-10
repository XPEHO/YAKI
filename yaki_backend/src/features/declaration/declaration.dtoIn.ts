import { StatusDeclaration } from "./status.enum";

/* Defining the interface for the declaration object. */
export class DeclarationDtoIn {
    declarationId: number;
    declarationTeamMateId: number;
    declarationDate: Date;
    declarationStatus: StatusDeclaration

    constructor(
        declarationId: number,
        declarationTeamMateId: number,
        declarationDate: Date,
        declarationStatus: StatusDeclaration
    ) {
        this.declarationId = declarationId;
        this.declarationTeamMateId = declarationTeamMateId;
        this.declarationDate = declarationDate;
        this.declarationStatus = declarationStatus
    }
}