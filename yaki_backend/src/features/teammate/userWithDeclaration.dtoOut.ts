import {StatusDeclaration} from "../declaration/status.enum";

export class UserWithDeclaration {
  userId: number;
  userLastName: string;
  userFirstName: string;
  declarationDate: Date;
  declarationStatus: StatusDeclaration;
  teamId: number;
  teamName: string;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationId: number;
  declarationUserId: number;

  constructor(
    userId: number,
    userLastName: string,
    userFirstName: string,
    declarationDate: Date,
    declarationStatus: StatusDeclaration,
    teamId: number,
    teamName: string,
    declarationDateStart: Date,
    declarationDateEnd: Date,
    declarationId: number,
    declarationUserId: number
  ) {
    this.userId = userId;
    this.userLastName = userLastName;
    this.userFirstName = userFirstName;
    this.declarationDate = declarationDate;
    this.declarationStatus = declarationStatus;
    this.teamId = teamId;
    this.teamName = teamName;
    this.declarationDateStart = declarationDateStart;
    this.declarationDateEnd = declarationDateEnd;
    this.declarationId = declarationId;
    this.declarationUserId = declarationUserId;
  }
}
