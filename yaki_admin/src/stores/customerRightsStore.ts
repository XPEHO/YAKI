import { defineStore } from "pinia";
import { CustomerType } from "@/models/customer.type";

export const useCustomerRightsStore = defineStore("customerRightsStore", {
  state: () => ({
    customersRigthsId: [] as number[],
    customersRights: [] as CustomerType[],
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
