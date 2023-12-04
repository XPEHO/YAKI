import {INVITEDROLE} from "@/constants/pathParam.enum";
import {UserWithIdType} from "@/models/userWithId.type";
import {customerService} from "@/services/customer.service";
import {useCaptainStore} from "@/stores/captainStore";
import {useSelectedRoleStore} from "@/stores/selectedRole";
import {useTeamStore} from "@/stores/teamStore";
import {useTeammateStore} from "@/stores/teammateStore";

const customeraddAdminPageRoute = "/customer/admin-invitation";

export const updateReactive = (current: Object, newReactive: Object) => {
  Object.assign(current, newReactive);
};

export const getListOfUserAlreadyAccepted = async (invitedRole: string) => {
  const selectedRoleStore = useSelectedRoleStore();
  const teammateStore = useTeammateStore();
  const captainStore = useCaptainStore();

  if (invitedRole == INVITEDROLE.teammate) {
    return teammateStore.getTeammateList.map((teammate) => teammate.id);
  } else if (invitedRole == INVITEDROLE.captain) {
    return captainStore.getCaptainList.map((captain) => captain.id);
  } else {
    return customerService.getAllUsersRightByCustomerId(selectedRoleStore.getCustomerIdSelected);
  }
};

export const checkInvitationStatus = (user: UserWithIdType, isUserAlreadyIn: number[], textStatus: string) => {
  const invitationStatus = {
    isInvited: false,
    text: "Invite",
    btnCSS: "button-class-test btn-bg-color-invite",
    cardCSS: "",
  };
  const isUserInTeam = isUserAlreadyIn.find((teammate) => teammate === user.id);
  if (isUserInTeam) {
    invitationStatus.isInvited = true;
    invitationStatus.text = textStatus;
    invitationStatus.btnCSS = "button-class-test btn-bg-color-present";
    invitationStatus.cardCSS = "user-invited";
  }

  return invitationStatus;
};

export const changeHeaderTitle = (invitedRole: string) => {
  let title = "";
  if (invitedRole === customeraddAdminPageRoute) {
    title = "Invite an Admin";
  } else if (invitedRole === INVITEDROLE.teammate) {
    title = "Invite a User";
  } else if (invitedRole === INVITEDROLE.captain) {
    title = "Invite a Captain";
  }
  return title;
};

export const changeHeaderSubText = (invitedRole: string, teamName: string) => {
  let subText = "";
  if (invitedRole === customeraddAdminPageRoute) {
    subText = "Select the person(s) you want to invit as admin : ";
  } else if (invitedRole === INVITEDROLE.teammate) {
    subText = `Select the user(s) you want to invit to : ${teamName}`;
  } else if (invitedRole === INVITEDROLE.captain) {
    subText = "Select the user(s) you want to invit as captain : ";
  }
  return subText;
};

export const invitUser = async (invitedRole: string, userId: number) => {
  const selectedRoleStore = useSelectedRoleStore();
  const teamStore = useTeamStore();

  if (invitedRole === customeraddAdminPageRoute) {
    selectedRoleStore.addAdminToCompany(userId);
  } else if (invitedRole === INVITEDROLE.teammate) {
    teamStore.addUserToTeam(userId);
  } else if (invitedRole === INVITEDROLE.captain) {
    selectedRoleStore.addCaptainToCompany(userId);
  }
};

export const getReturnText = (invitedRole: string) => {
  if (invitedRole == INVITEDROLE.teammate) {
    return "return to teammate List";
  } else {
    return "return to captain List";
  }
};

export const getInvitationStatusText = (invitedRole: string) => {
  if (invitedRole == INVITEDROLE.teammate) {
    return "In team";
  } else if (invitedRole == INVITEDROLE.captain) {
    return "already captain";
  } else {
    return "already admin";
  }
};
