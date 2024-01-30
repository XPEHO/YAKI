import { UserPagesResponseType } from "@/models/userPages.type";
import { UserWithIdType } from "@/models/userWithId.type";
import { usersService } from "@/services/users.service";
import { defineStore } from "pinia";

interface State {
  pageNumber: number;
  totalPagesCount: number;
  itemsPerPage: number;
  users: UserWithIdType[];
}

export const useUserStore = defineStore("userStore", {
  state: () => ({
    pageNumber: 0 as number,
    totalPagesCount: 0 as number,
    itemsPerPage: 10 as number,
    users: [] as UserWithIdType[],
  }),

  getters: {
    getPageNumber: (state: State) => state.pageNumber,
    getTotalPagesCount: (state: State) => state.totalPagesCount,
    getitemsPerPage: (state: State) => state.itemsPerPage,
    getUsers: (state: State) => state.users,
  },

  actions: {
    setPageNumber(pageNumber: number) {
      //prevent negative page number
      if (pageNumber >= 0) this.pageNumber = pageNumber;
      //prevent page number greater than total pages count
      if (pageNumber >= this.totalPagesCount) this.pageNumber = this.totalPagesCount - 1;
    },

    setitemsPerPage(itemsPerPage: number) {
      this.itemsPerPage = itemsPerPage;
    },

    async getUsersByPage() {
      const serviceResponse: UserPagesResponseType = await usersService.getUsersByPage(
        this.pageNumber,
        this.itemsPerPage,
      );
      this.users = serviceResponse.users;
      this.totalPagesCount = serviceResponse.totalPages;
    },
  },
});
