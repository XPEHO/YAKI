import { defineStore } from "pinia";
import { CaptainType } from "@/models/captain.type";
import { captainService } from "@/services/captain.service";

export const useCaptainStore = defineStore("captainStore", {
  state: () => ({
    customerId: [] as number[],
    captainId: 0 as number,
    captainList: [] as CaptainType[],
    captainToDelete: 0 as number,
  }),
  getters: {
    getCustomerId(): number[] {
      return this.customerId;
    },
    getCaptainId(): number {
      return this.captainId;
    },
    getCaptainList(): CaptainType[] {
      return this.captainList;
    },
    getCaptainToDelete(): number {
      return this.captainToDelete;
    },
  },

  actions: {
    setCaptainId(captainId: number) {
      this.captainId = captainId;
    },
    setCustomerId(customerId: number[]) {
      this.customerId = customerId;
    },

    // get all captains of a customer
    async getAllCaptainsByCustomerId(customerId: number[]) {
      this.captainList = [];
      for (const id of customerId) {
        const result = await captainService.getAllCaptainsByCustomerId(id);
        this.captainList = this.captainList.concat(result);
      }
    },

    // create a captain
    async createCaptain(data: CaptainType): Promise<void> {
      await captainService.createCaptain(data);
    },

    //get the captainId to delete
    setCaptainToDelete(captainId: number) {
      this.captainToDelete = captainId;
    },

    //delete a captain
    async deleteCaptain(captainId: number): Promise<void> {
      await captainService.deleteCaptain(captainId);
    },
  },
});
