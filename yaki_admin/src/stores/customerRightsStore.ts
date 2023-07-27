import { defineStore } from "pinia";
import { CustomersRightsType } from "@/models/customersRights.type";

export const useCustomerRightsStore = defineStore("customerRightsStore", {
  state: () => ({
    customersRigthsId: [] as number[],
    customersRights: [] as CustomersRightsType[],
  }),
  getters: {
    getCustomersRightsId(): number[] {
      return this.customersRigthsId;
    },
  },
  actions: {
    setCustomersRightsId(customersRightsId: number[]) {
      this.customersRigthsId = customersRightsId;
    },
  },
});
