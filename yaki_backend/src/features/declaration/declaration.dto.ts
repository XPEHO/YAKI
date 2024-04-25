import {StatusDeclaration} from "./status.enum";

/* 
Data coming from the front - flutter - 
*/
export class DeclarationDto {
  declarationUserId: number;
  declarationDate: Date;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationStatus: StatusDeclaration;
  declarationTeamId: number | null;

  constructor(
    declarationUserId: number,
    declarationDate: Date,
    declarationDateStart: Date,
    declarationDateEnd: Date,
    declarationStatus: StatusDeclaration,
    declarationTeamId: number
  ) {
    this.declarationUserId = declarationUserId;
    this.declarationDate = declarationDate;
    this.declarationDateStart = declarationDateStart;
    this.declarationDateEnd = declarationDateEnd;
    this.declarationStatus = declarationStatus;
    this.declarationTeamId = declarationTeamId;
  }
}
