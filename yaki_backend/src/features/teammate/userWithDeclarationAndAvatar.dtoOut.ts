import {StatusDeclaration} from "../declaration/status.enum";

export class UsersWithDeclarationAndAvatar {
  userId: number;
  userLastName: string;
  userFirstName: string;
  declarationDate: Date;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationStatus: StatusDeclaration;
  teamId: number;
  teamName: string;
  teamCustomerId: number;
  customerName: string;
  avatarReference: string | null;
  avatarByteArray: number[] | null;

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
    customerName: string,
    avatarReference: string | null,
    avatarByteArray: number[] | null
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
    this.avatarReference = avatarReference;
    this.avatarByteArray = avatarByteArray;
  }
}

export interface UsersWithDeclarationAndAvatarInterface {
  userId: number;
  userLastName: string;
  userFirstName: string;
  declarationDate: Date;
  declarationDateStart: Date;
  declarationDateEnd: Date;
  declarationStatus: StatusDeclaration;
  teamId: number;
  teamName: string;
  teamCustomerId: number;
  customerName: string;
  avatarReference: string | null;
  avatarByteArray: number[] | null;
}
