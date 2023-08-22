
import { defineStore } from "pinia";

export const useRoleStore = defineStore("roleStore", {
  state: () => ({
    customersIdWhereIgotRights : [] as number[],
    customersIdWhereAmCaptain: [] as number[],
    captainsId: [] as number[],
    
  }),
  getters: {
    getCustomersIdWhereIgotRights(): number[] {
      return this.customersIdWhereIgotRights;
    },
    getCustomersIdWhereAmCaptain(): number[] {
      return this.customersIdWhereAmCaptain;
    },
    getCaptainsId(): number[] {
      return this.captainsId;
    },
  },
  actions: {
    setCustomersIdWhereAmCaptain(customersId: number[]) {
        this.customersIdWhereAmCaptain = customersId;
    },
    setCustomersIdWhereIgotRights(customersRightsId: number[]) {
      this.customersIdWhereIgotRights = customersRightsId;
    },
    setCaptainsId(captainsId: number[]) {
      this.captainsId = captainsId;
    },
  },
});