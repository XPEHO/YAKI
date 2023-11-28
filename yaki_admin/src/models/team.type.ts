export type TeamType = {
  id: number;
  teamName: string;
  customerId: number;
  captainsId: number[];
  captains: CaptainDetails[];
};

export type CaptainDetails = {
  captainId: number;
  firstName: string;
  lastName: string;
};

export type TeamTypeOut = {
  captainsId: (number | null)[];
  teamName: string | null;
  customerId: number | null;
};
