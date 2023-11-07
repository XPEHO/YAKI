import {AvatarEnum} from "./avatar.enum";
export class UserInformationDto {
  userLastname: string;
  userFirstname: string;
  userEmail: string;
  userAvatarChoice: AvatarEnum;

  constructor(userLastname: string, userFirstname: string, userEmail: string, userAvatarChoice: AvatarEnum) {
    this.userLastname = userLastname;
    this.userFirstname = userFirstname;
    this.userEmail = userEmail;
    this.userAvatarChoice = userAvatarChoice;
  }
}
