export type UserWithIdType = {
  id: number;
  captainId: number;
  teammateId: number;
  firstname: string;
  lastname: string;
  email: string;
  avatarReference: string;
  avatarBlob: Uint8Array;
};
