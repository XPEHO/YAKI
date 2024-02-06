import { UserWithIdType } from "./userWithId.type";

export type UserPagesResponseType = {
  totalPages: number;
  users: UserWithIdType[];
};
