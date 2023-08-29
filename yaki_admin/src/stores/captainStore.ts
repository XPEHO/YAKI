import {defineStore} from "pinia";
import {CaptainType} from "@/models/captain.type";
import {captainService} from "@/services/captain.service";
import {UserWithIdType} from "@/models/userWithId.type";

export const useCaptainStore = defineStore("captainStore", {
  state: () => ({
    //list of captains display in the view customer
    captainList: [] as UserWithIdType[],
    // in the customer view, when a captain is selected to maybe be deleted
    // at delete icon press, the captainID will be saved
    captainToDelete: 0 as number,
  }),
  getters: {
    getCaptainList(): UserWithIdType[] {
      return this.captainList;
    },
    getCaptainToDelete(): number {
      return this.captainToDelete;
    },
  },

  actions: {
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
