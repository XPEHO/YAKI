import { UserWithIdType } from "@/models/userWithId.type";
import { AVATARENUM } from "@/constants/avatar.enum";
import avatarH from "@/assets/images/avatarH.svg";
import avatarF from "@/assets/images/avatarF.svg";
import avatarN from "@/assets/images/avatarN.svg";
import teamImage from "@/assets/images/teamDefaultImg2.svg";

export const setUserAvatarUrl = (user: UserWithIdType) => {
  console.log("case0");
  console.log(`avatarReference: ${user.avatarReference}`);
  switch (user.avatarReference) {
    case AVATARENUM.userPicture:
      console.log("case1");
      return `data:image/jpeg;base64,${user.avatarBlob}`;
    case AVATARENUM.avatarH:
      console.log("case2");
      return avatarH;
    case AVATARENUM.avatarF:
      console.log("case3");
      return avatarF;
    case AVATARENUM.avatarN:
      console.log("case4");
      return avatarN;
    default:
      console.log("case5");
      return "";
  }
};

export const setTeamLogoUrl = (teamLogo: Uint8Array | null) => {
  if (teamLogo) {
    return `data:image/jpeg;base64,${teamLogo}`;
  } else {
    return teamImage;
  }
};
