import { defineStore } from "pinia";

import { loginService } from "@/services/login.service";
import router from "@/router/router";

import { CaptainType } from "@/models/captain.type";
import { CustomerType } from "@/models/customer.type";
import { useRoleStore } from "./roleStore";
import { useSelectedRoleStore } from "./selectedRole";
import { useModalStore } from "./modalStore";

export const useAuthStore = defineStore("loginStore", {
  state: () => ({
    captains: [] as CaptainType[],
    customersRights: [] as CustomerType[],
    user: (() => {
      const userString = localStorage.getItem("user");
      return userString ? JSON.parse(userString) : "";
    })(),
    returnedUrl: null as string | null,
  }),
  actions: {
    async login(login: string, password: string): Promise<boolean> {
      const modalStore = useModalStore();

      try {
        const userEntity = await loginService.login(login, password);

        this.user = {
          user_id: userEntity.userId,
          token: userEntity.token,
        };
        if (userEntity.customerId.length == 0 && userEntity.captainId.length == 0) {
          this.logout();
          return false;
        }
        localStorage.setItem("user", JSON.stringify(this.user));
        //if the user is not a captain or a customer, he can't access to the admin part

        const selectedRoleStore = useSelectedRoleStore();
        const roleStore = useRoleStore();
        //in what route the user will be redirect depending of his rights.
        if (userEntity.customerId.length >= 1) {
          this.returnedUrl = "/dashboard/manage-captains";
          selectedRoleStore.setCustomerIdSelected(userEntity.customerId[0]);
        } else {
          //if not a customer it's necessarily a captain
          this.returnedUrl = "/dashboard/manage-team";
          //set the tab to the first captain
          selectedRoleStore.setCaptainIdSelected(userEntity.captainId[0]);
        }
        //temporary we must choose the customer then.

        roleStore.setCaptainsId(userEntity.captainId);
        roleStore.setCustomersIdWhereIgotRights(userEntity.customerId);

        // reset the modal state(visibility, mode, and input values) in case of the user was in the middle of a modal action
        // and then redirected to the login page for some reason
        modalStore.resetStates();

        router.push(this.returnedUrl);
        return true;
      } catch {
        return false;
      }
    },

    logout() {
      this.user = null;
      localStorage.removeItem("user");
      router.push("/");
    },
  },
});
