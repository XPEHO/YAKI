import {StatusDeclaration} from "../declaration/status.enum";

export class UserWithDeclaration {
  userId: number;
  userLastName: string;
  userFirstName: string;
  declarationDate: Date;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationStatus: StatusDeclaration;
  teamId: number | null;
  teamName: string | null;
  teamCustomerId: number | null;
  customerName: string | null;

  constructor(
    userId: number,
    userLastName: string,
    userFirstName: string,
    declarationDate: Date,
    declarationDateStart: Date,
    declarationDateEnd: Date,
    declarationStatus: StatusDeclaration,
    teamId: number,
    teamName: string,
    teamCustomerId: number,
    customerName: string
  ) {
    this.userId = userId;
    this.userLastName = userLastName;
    this.userFirstName = userFirstName;
    this.declarationDate = declarationDate;
    this.declarationDateStart = declarationDateStart;
    this.declarationDateEnd = declarationDateEnd;
    this.declarationStatus = declarationStatus;
    this.teamId = teamId;
    this.teamName = teamName;
    this.teamCustomerId = teamCustomerId;
    this.customerName = customerName;
  }
}
