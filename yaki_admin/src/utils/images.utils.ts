import {UserWithIdType} from "@/models/userWithId.type";
import {AVATARENUM} from "@/constants/avatar.enum";
import avatarH from "@/assets/images/avatarH.svg";
import avatarF from "@/assets/images/avatarF.svg";
import avatarN from "@/assets/images/avatarN.svg";
import userAvatar from "@/assets/images/avatar_2.png";

export const setUserAvatarUrl = (user: UserWithIdType) => {
  switch (user.avatarReference) {
    case AVATARENUM.userPicture:
      return `data:image/jpeg;base64,${user.avatarBlob}`;
    case AVATARENUM.avatarH:
      return avatarH;
    case AVATARENUM.avatarF:
      return avatarF;
    case AVATARENUM.avatarN:
      return avatarN;
    default:
      return userAvatar;
  }
};
