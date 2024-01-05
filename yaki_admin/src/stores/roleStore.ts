import { defineStore } from "pinia";

/*
  All captains role and/or customers rights a user 
  able to connect on the admin applicatin can have.
*/
export const useRoleStore = defineStore("roleStore", {
  state: () => ({
    customersIdWhereIgotRights: [] as number[],
    customersIdWhereAmCaptain: [] as number[],
    // all captains id a user can have
    captainsId: [] as number[],
    customerId: 0 as number,
    captainId: 0 as number,
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
    getCustomerId(): number {
      return this.customerId;
    },
    getCaptainId(): number {
      return this.captainId;
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
    setCustomerId(customerId: number) {
      this.customerId = customerId;
    },
    setCaptainId(captainId: number) {
      this.captainId = captainId;
    },
  },
});
