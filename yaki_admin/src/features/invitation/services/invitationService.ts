import {UserWithIdType} from "@/models/userWithId.type";
import { customerService } from "@/services/customer.service";
import { useCaptainStore } from "@/stores/captainStore";
import { useSelectedRoleStore } from "@/stores/selectedRole";
import { useTeamStore } from "@/stores/teamStore";
import {useTeammateStore} from "@/stores/teammateStore";

const captainPageRoute = "/captain/invitation";
const customerPageRoute = "/customer/invitation";
const customeraddAdminPageRoute = "/customer/admin-invitation";

export const updateReactive = (current: Object, newReactive: Object) => {
  Object.assign(current, newReactive);
};
export const getInvitationStatusText = (fromRoute: string) => {
  if (fromRoute == captainPageRoute) {
    return "In team";
  }
  else if (fromRoute == customerPageRoute) {
    return "already captain";
  }
  else{
    return "already admin";
  }
}
export  const  getListOfUserAlreadyAccepted = async (fromRoute: string) => {
  const selectedRoleStore = useSelectedRoleStore();
  const teammateStore = useTeammateStore();
  const captainStore = useCaptainStore();
  if (fromRoute == captainPageRoute) {
    return teammateStore.getTeammateList.map(teammate => teammate.userId);
  }
  else if (fromRoute == customerPageRoute) {
    return captainStore.getCaptainList.map(captain => captain.id);
  }
  else{
    return customerService.getAllUsersRightByCustomerId(selectedRoleStore.getCustomerIdSelected);
    
  }
}
export const getReturnText = (fromRoute: string) => {
  if (fromRoute == captainPageRoute) {
    return "return to teammate List";
  }
  else{
    return "return to captain List";
  }
}
export const checkInvitationStatus = (user: UserWithIdType,userAlreadyIn: number[],textStatus : string) => {
  const invitationStatus = {
    isInvited: false,
    text: "Invite",
    btnCSS: "button-class-test btn-bg-color-invite",
    cardCSS: "",
  };
  const isUserInTeam = userAlreadyIn.find((teammate) => teammate === user.id);
  if (isUserInTeam) {
    invitationStatus.isInvited = true;
    invitationStatus.text = textStatus;
    invitationStatus.btnCSS = "button-class-test btn-bg-color-present";
    invitationStatus.cardCSS = "user-invited";
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
    selectedRoleStore.addCaptainToCompany(userId);
  }
}
