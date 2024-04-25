import {StatusDeclaration} from "./status.enum";

/* 
Defining the interface for the declaration object.
Data coming from the database
*/
export class DeclarationDtoIn {
  declarationId: number;
  declarationUserId: number;
  declarationDate: Date;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationStatus: StatusDeclaration;
  declarationTeamId: number | null;

  constructor(
    declarationId: number,
    declarationUserId: number,
    declarationDate: Date,
    declarationDateStart: Date,
    declarationDateEnd: Date,
    declarationStatus: StatusDeclaration,
    declarationTeamId: number
  ) {
    this.declarationId = declarationId;
    this.declarationUserId = declarationUserId;
    this.declarationDate = declarationDate;
    this.declarationDateStart = declarationDateStart;
    this.declarationDateEnd = declarationDateEnd;
    this.declarationStatus = declarationStatus;
    this.declarationTeamId = declarationTeamId;
  }
}
