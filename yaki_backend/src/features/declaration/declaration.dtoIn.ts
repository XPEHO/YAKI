import {StatusDeclaration} from "./status.enum";

/* Defining the interface for the declaration object. */
export class DeclarationDtoIn {
  declarationId: number;
  declarationTeamMateId: number;
  declarationDate: Date;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationStatus: StatusDeclaration;

  constructor(
    declarationId: number,
    declarationTeamMateId: number,
    declarationDate: Date,
    declarationDateStart: Date,
    declarationDateEnd: Date,
    declarationStatus: StatusDeclaration
  ) {
    this.declarationId = declarationId;
    this.declarationTeamMateId = declarationTeamMateId;
    this.declarationDate = declarationDate;
    this.declarationDateStart = declarationDateStart;
    this.declarationDateEnd = declarationDateEnd;
    this.declarationStatus = declarationStatus;
  }
}
