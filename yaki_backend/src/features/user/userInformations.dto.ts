import {AvatarEnum} from "./avatar.enum";
export class UserInformationDto {
  lastname: string;
  firstname: string;
  email: string;
  avatarChoice?: AvatarEnum;

  constructor(userLastname: string, userFirstname: string, userEmail: string, userAvatarChoice: AvatarEnum) {
    this.lastname = userLastname;
    this.firstname = userFirstname;
    this.email = userEmail;
    this.avatarChoice = userAvatarChoice;
  }
}
