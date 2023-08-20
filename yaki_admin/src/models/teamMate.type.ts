export type TeammateType = {
  id: number;
  teamId: number;
  userId: number;
  firstName: string;
  lastName: string;
  email: string;
};

export type TeammateTypeIn = {
  id: number;
  teamId: number;
  userId: number;
};

export type TeammateTypeOut = {
  teamId: number;
  userId: number;
};
