import { captainService } from "@/services/captain.service";
import { defineStore } from "pinia";

export const useSelectedRoleStore = defineStore("selectedRoleStore", {
  state: () => ({
    //to create a team you need to have a captainId and a customerId
    //or only a customerId if you are a customer
    customerIdSelected : 0 as number,
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
      let captain = await captainService.getCaptain(captainId);
      this.setCustomerIdSelected(captain.customerId)
    }
  },
});