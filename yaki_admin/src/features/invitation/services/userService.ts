import {UserWithIdType} from "@/models/userWithId.type";
import {useTeamStore} from "@/stores/teamStore";

const captainPageRoute = "/captain/invitation";
const customerPageRoute = "/customer/invitation";

export const updateReactive = (current: Object, newReactive: Object) => {
  Object.assign(current, newReactive);
};

export const checkInvitationStatus = (user: UserWithIdType) => {
  const invitationStatus = {
    isInvited: false,
    text: "Invite",
    btnCSS: "button-class-test btn-bg-color-invite",
    cardCSS: "",
  };

  const teamStore = useTeamStore();
  const isUserInTeam = teamStore.getTeammateList.find((teammate) => teammate.userId === user.id);

  if (isUserInTeam) {
    invitationStatus.isInvited = true;
    invitationStatus.text = "In Team";
    invitationStatus.btnCSS = "button-class-test btn-bg-color-present";
    invitationStatus.cardCSS = "user-invited";
  }

  return invitationStatus;
};

// /captain/invitation || /customer/invitation

export const changeHeaderTitle = (fromRoute: string) => {
  let title = "";
  if (fromRoute === captainPageRoute) {
    title = "Invite a User";
  } else if (fromRoute === customerPageRoute) {
    title = "Invite a Captain";
  }
  return title;
};

export const changeHeaderSubText = (fromRoute: string, teamName: string) => {
  let subText = "";
  if (fromRoute === captainPageRoute) {
    subText = `Select the user(s) you want to invit to : ${teamName}`;
  } else if (fromRoute === customerPageRoute) {
    subText = "Select the user(s) you want to invit as captain : ";
  }
  return subText;
};
