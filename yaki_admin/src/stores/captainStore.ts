import { defineStore } from "pinia";
import { CaptainType } from "@/models/captain.type";
import { captainService } from "@/services/captain.service";
import { UserWithIdType } from "@/models/userWithId.type";
import { useRoleStore } from "@/stores/roleStore";

interface State {
  captainList: UserWithIdType[];
  idOfCaptainToDelete: number;
  currentCustomerId: number;
}

export const useCaptainStore = defineStore("captainStore", {
  state: () => ({
    //list of captains display in the view customer
    captainList: [] as UserWithIdType[],
    // in the customer view, when a captain is selected to maybe be deleted
    // at delete icon press, the captainID will be saved
    idOfCaptainToDelete: 0 as number,
    currentCustomerId: 0 as number,
  }),
  getters: {
    getCaptainList: (state: State) => state.captainList,
    getCaptainToDelete: (state: State) => state.idOfCaptainToDelete,
    getCurrentCustomerId: (state: State) => state.currentCustomerId,
  },

  actions: {
    //get the captainId to delete
    setCaptainToDelete(captainId: number) {
      this.idOfCaptainToDelete = captainId;
    },

    // get all captains of a customer
    async setAllCaptainsByCustomerId(customerId: number) {
      this.currentCustomerId = customerId;
      this.captainList = await captainService.getAllCaptainsByCustomerId(customerId);
    },

    // create a captain
    async createCaptain(data: CaptainType): Promise<void> {
      await captainService.createCaptain(data);
    },

    //delete a captain (disabled)
    async deleteCaptain(): Promise<void> {
      await captainService.disabledCaptain(this.idOfCaptainToDelete);
      //refresh captain list
      await this.setAllCaptainsByCustomerId(this.getCurrentCustomerId);
    },

    /**
     * Refresh the captain list.
     */
    async refreshCaptainList() {
      const roleStore = useRoleStore();
      await this.setAllCaptainsByCustomerId(roleStore.getCustomerId);
    },
  },
});
