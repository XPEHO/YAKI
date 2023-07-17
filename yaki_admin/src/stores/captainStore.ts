import { defineStore } from "pinia";
import { CaptainType } from "@/models/captain.type";
import { captainService } from "@/services/captain.service";

export const useCaptainStore = defineStore("captainStore", {
    state: () => ({
      customerId : [] as number[],
      captainId: 0 as number,

    }),
  }),
  getters: {};
actions: {
}