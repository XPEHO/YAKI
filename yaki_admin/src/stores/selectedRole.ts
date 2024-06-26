import { captainService } from "@/services/captain.service";
import { customerService } from "@/services/customer.service";
import { defineStore } from "pinia";
import { useCaptainStore } from "./captainStore";

/*
  Explanation :
  I'am a captain or i have customer rights in different companies.
  During administration operation i need to select for which company i'am doing it.
*/
export const useSelectedRoleStore = defineStore("selectedRoleStore", {
  state: () => ({
    //to create a team you need to have a captainId and a customerId
    //or only a customerId if you are a customer
    customerIdSelected: 0 as number,
    captainIdSelected: 0 as number,
  }),
  getters: {
    getCustomerIdSelected(): number {
      return this.customerIdSelected;
    },
    getCaptainIdSelected(): number {
      return this.captainIdSelected;
    },
  },
  actions: {
    setCustomerIdSelected(customerId: number) {
      this.customerIdSelected = customerId;
    },
    setCaptainIdSelected(captainId: number) {
      this.captainIdSelected = captainId;
      this.fetchCustomerIdSelected(captainId);
    },
    async fetchCustomerIdSelected(captainId: number) {
      const captain = await captainService.getCaptain(captainId);
      this.setCustomerIdSelected(captain.customerId);
    },
    async addAdminToCompany(userId: number) {
      await customerService.addCustomerRights(this.customerIdSelected, userId);
    },
    async addCaptainToCompany(userId: number) {
      const captainStore = useCaptainStore();
      captainStore
        .addCaptainRight({ id: 0, userId: userId, customerId: this.customerIdSelected })
        .then(() => {
          //reload the captain list
          captainStore.setAllCaptainsByCustomerId(this.customerIdSelected);
        });
    },
  },
});
