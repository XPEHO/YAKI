export type TeamMateType = {
  id: number;
  teamId: number;
  userId: number;
  firstName: string;
  lastName: string;
  email: string;
};

export type TeammateReturnType = {
  id: number;
  teamId: number;
  userId: number;
};

export type TeammateToCreateType = {
  teamId: number;
  userId: number;
};
