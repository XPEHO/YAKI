import {StatusDeclaration} from "../declaration/status.enum";

export class AbsenceDeclarationDto {
  declarationUserId: number;
  declarationDate: Date;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationStatus: StatusDeclaration;

  constructor(
    declarationUserId: number,
    declarationDate: Date,
    declarationDateStart: Date,
    declarationDateEnd: Date,
    declarationStatus: StatusDeclaration
  ) {
    this.declarationUserId = declarationUserId;
    this.declarationDate = declarationDate;
    this.declarationDateStart = declarationDateStart;
    this.declarationDateEnd = declarationDateEnd;
    this.declarationStatus = declarationStatus;
  }
}
