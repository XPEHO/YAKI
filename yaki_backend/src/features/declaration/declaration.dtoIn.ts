import {StatusDeclaration} from "./status.enum";

/* Defining the interface for the declaration object. */
export class DeclarationDtoIn {
  declarationId: number;
  declarationTeamMateId: number;
  declarationDate: Date;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationStatus: StatusDeclaration;
  declarationTeamId: number;

  constructor(
    declarationId: number,
    declarationTeamMateId: number,
    declarationDate: Date,
    declarationDateStart: Date,
    declarationDateEnd: Date,
    declarationStatus: StatusDeclaration,
    declarationTeamId: number
  ) {
    this.declarationId = declarationId;
    this.declarationTeamMateId = declarationTeamMateId;
    this.declarationDate = declarationDate;
    this.declarationDateStart = declarationDateStart;
    this.declarationDateEnd = declarationDateEnd;
    this.declarationStatus = declarationStatus;
    this.declarationTeamId = declarationTeamId;
  }
}
