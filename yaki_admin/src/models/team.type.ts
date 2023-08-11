export type TeamType = {
  id: number;
  captainsId: number[];
  teamName: string;
  customerId: number;
};

export type TeamTypeOut = {
  "captainsId": number[];
  "teamName": string;
  "customerId": number;
};
