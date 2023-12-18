import {UserWithIdType} from "@/models/userWithId.type";
import {AVATARENUM} from "@/constants/avatar.enum";
import avatarH from "@/assets/images/avatarH.svg";
import avatarF from "@/assets/images/avatarF.svg";
import avatarN from "@/assets/images/avatarN.svg";
import userAvatar from "@/assets/images/avatar_2.png";

export const setUserAvatarUrl = (user: UserWithIdType) => {
  let avatarUrl;
  switch (user.avatarReference) {
    case AVATARENUM.userPicture:
      avatarUrl = `data:image/jpeg;base64,${user.avatarBlob}`;
      break;
    case AVATARENUM.avatarH:
      avatarUrl = avatarH;
      break;
    case AVATARENUM.avatarF:
      avatarUrl = avatarF;
      break;
    case AVATARENUM.avatarN:
      avatarUrl = avatarN;
      break;
    default:
      avatarUrl = userAvatar;
  }
  return avatarUrl;
};
