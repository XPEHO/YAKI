export type TeammateTypeIn = {
  id: number;
  teamId: number;
  userId: number;
};

export type TeammateTypeOut = {
  teamId: number;
  userId: number;
};

export type TeammateType = {
  id: number;
  firstname: string;
  lastname: string;
  email: string;
  teamId: number;
  userId: number;
};
