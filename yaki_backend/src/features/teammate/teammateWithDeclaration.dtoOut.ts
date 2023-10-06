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

  constructor(
    userId: number,
    teammateId: number,
    userLastName: string,
    userFirstName: string,
    declarationDate: Date,
    declarationStatus: StatusDeclaration,
    teamId: number,
    teamName: string
  ) {
    this.userId = userId;
    this.teammateId = teammateId;
    this.userLastName = userLastName;
    this.userFirstName = userFirstName;
    this.declarationDate = declarationDate;
    this.declarationStatus = declarationStatus;
    this.teamId = teamId;
    this.teamName = teamName;
  }
}
