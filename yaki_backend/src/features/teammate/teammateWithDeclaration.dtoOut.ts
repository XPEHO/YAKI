import {StatusDeclaration} from "../declaration/status.enum";

export class TeammateWithDeclaration {
  userId: number;
  teammateId: number;
  userLastName: string;
  userFirstName: string;
  declarationDate: Date;
  declarationStatus: StatusDeclaration;

  constructor(
    userId: number,
    teammateId: number,
    userLastName: string,
    userFirstName: string,
    declarationDate: Date,
    declarationStatus: StatusDeclaration
  ) {
    this.userId = userId;
    this.teammateId = teammateId;
    this.userLastName = userLastName;
    this.userFirstName = userFirstName;
    this.declarationDate = declarationDate;
    this.declarationStatus = declarationStatus;
  }
}
