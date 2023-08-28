import {UserWithIdType} from "@/models/userWithId.type";
import { useSelectedRoleStore } from "@/stores/selectedRole";
import { useTeamStore } from "@/stores/teamStore";
import {useTeammateStore} from "@/stores/teammateStore";

const captainPageRoute = "/captain/invitation";
const customerPageRoute = "/customer/invitation";
const customeraddAdminPageRoute = "/customer/addAdminInvitation";

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

  const teammateStore = useTeammateStore();
  const isUserInTeam = teammateStore.getTeammateList.find((teammate) => teammate.userId === user.id);

  if (isUserInTeam) {
    invitationStatus.isInvited = true;
    invitationStatus.text = "In Team";
    invitationStatus.btnCSS = "button-class-test btn-bg-color-present";
    invitationStatus.cardCSS = "user-invited";
  }

  return invitationStatus;
};

export const checkInvitationStatusAdmin = (user: UserWithIdType,usersWithAdminRights: number[]) => {

  const invitationStatus = {
    isInvited: false,
    text: "Invite",
    btnCSS: "button-class-test btn-bg-color-invite",
    cardCSS: "",
  };

  const teammateStore = useTeammateStore();
  const isUserAdmin = usersWithAdminRights.find((userId) => userId === user.id);

  if (isUserAdmin) {
    invitationStatus.isInvited = true;
    invitationStatus.text = "Already Admin";
    invitationStatus.btnCSS = "button-class-test btn-bg-color-present";
    invitationStatus.cardCSS = "invited";
  }

  return invitationStatus;
};
// /captain/invitation || /customer/invitation

export const changeHeaderTitle = (fromRoute: string) => {
  let title = "";
  if(fromRoute === customeraddAdminPageRoute){
    title = "Invite an Admin";
  }
  else if (fromRoute === captainPageRoute) {
    title = "Invite a User";
  } else if (fromRoute === customerPageRoute) {
    title = "Invite a Captain";
  }
  return title;
};

export const changeHeaderSubText = (fromRoute: string, teamName: string) => {
  let subText = "";
  if(fromRoute === customeraddAdminPageRoute){
    subText = "Select the person(s) you want to invit as admin : ";
  }
  else if (fromRoute === captainPageRoute) {
    subText = `Select the user(s) you want to invit to : ${teamName}`;
  } else if (fromRoute === customerPageRoute) {
    subText = "Select the user(s) you want to invit as captain : ";
  }
  return subText;
};

export const invitUser = async (fromRoute: string, userId: number,) => {
  const selectedRoleStore = useSelectedRoleStore();
  const teamStore = useTeamStore();
  if(fromRoute === customeraddAdminPageRoute){
    selectedRoleStore.addAdminToCompany(userId);
  }
  else if (fromRoute === captainPageRoute) {
    teamStore.addUserToTeam(userId);
  }
  else if(fromRoute === customerPageRoute){

    //not handled yet
  }
}
