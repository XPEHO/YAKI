import { defineStore } from "pinia";
import { CaptainType } from "@/models/captain.type";
import { captainService } from "@/services/captain.service";
import { UserWithIdType } from "@/models/userWithId.type";

export const useCaptainStore = defineStore("captainStore", {
  state: () => ({
    //captain id for the view customer where he got the list of captain view
    //so its the captain id of the selected captain
    captainIdSelected: 0 as number,
    //list of captains display in the view customer
    captainList: [] as UserWithIdType[], 
    captainToDelete: 0 as number,
  }),
  getters: {
    getCaptainIdSelected(): number {
      return this.captainIdSelected;
    },
    getCaptainList(): UserWithIdType[] {
      return this.captainList;
    },
    getCaptainToDelete(): number {
      return this.captainToDelete;
    },
  },

  actions: {
    setCaptainId(captainId: number) {
      this.captainIdSelected = captainId;
    },

    // get all captains of a customer
    async setAllCaptainsByCustomerId(customerId: number) {
      this.captainList = await captainService.getAllCaptainsByCustomerId(customerId);
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
