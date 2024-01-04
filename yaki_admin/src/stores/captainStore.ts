import { defineStore } from "pinia";
import { CaptainType } from "@/models/captain.type";
import { captainService } from "@/services/captain.service";
import { UserWithIdType } from "@/models/userWithId.type";

interface State {
  captainList: UserWithIdType[];
  captainToDelete: number;
}

export const useCaptainStore = defineStore("captainStore", {
  state: () => ({
    //list of captains display in the view customer
    captainList: [] as UserWithIdType[],
    // in the customer view, when a captain is selected to maybe be deleted
    // at delete icon press, the captainID will be saved
    captainToDelete: 0 as number,
  }),
  getters: {
    getCaptainList: (state: State) => state.captainList,
    getCaptainToDelete: (state: State) => state.captainToDelete,
  },
  actions: {
    //get the captainId to delete
    setCaptainToDelete(captainId: number) {
      this.captainToDelete = captainId;
    },

    // get all captains of a customer
    async setAllCaptainsByCustomerId(customerId: number) {
      this.captainList = await captainService.getAllCaptainsByCustomerId(customerId);
    },

    // create a captain
    async createCaptain(data: CaptainType): Promise<void> {
      await captainService.createCaptain(data);
    },

    //delete a captain
    async deleteCaptain(captainId: number): Promise<void> {
      await captainService.deleteCaptain(captainId);
    },
  },
});
