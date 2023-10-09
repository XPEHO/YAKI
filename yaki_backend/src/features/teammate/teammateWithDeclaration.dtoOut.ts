import { StatusDeclaration } from '../declaration/status.enum';

export class TeammateWithDeclaration {
  userId: number;
  teammateId: number;
  userLastName: string;
  userFirstName: string;
  declarationDate: Date;
  declarationStatus: StatusDeclaration;
  teamId: number;
  teamName: string;
  declarationDateStart: Date;
  declarationDateEnd: Date;

  constructor(
    userId: number,
    teammateId: number,
    userLastName: string,
    userFirstName: string,
    declarationDate: Date,
    declarationStatus: StatusDeclaration,
    teamId: number,
    teamName: string,
    declarationDateStart: Date,
    declarationDateEnd: Date
  ) {
    this.userId = userId;
    this.teammateId = teammateId;
    this.userLastName = userLastName;
    this.userFirstName = userFirstName;
    this.declarationDate = declarationDate;
    this.declarationStatus = declarationStatus;
    this.teamId = teamId;
    this.teamName = teamName;
    this.declarationDateStart = declarationDateStart;
    this.declarationDateEnd = declarationDateEnd;
  }
}
