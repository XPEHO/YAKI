import { defineStore } from "pinia";


export const useCustomerStore = defineStore("customerStore", {
  state: () => ({
    customerIdSelected: 0 as number,
  }),
  getters: {
    getCustomerIdSelected(): number {
      return this.customerIdSelected;
    },
  },
  actions: {
    setCustomerIdSelected(customerId: number) {
      return this.customerIdSelected = customerId;
    },
  },
});