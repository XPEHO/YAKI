export type TeamType = {
  id: number;
  teamName: string;
  customerId: number;
  captainsId: number[];
  captains: CaptainDetails[];
  teamDescription: string | null;
  lastActivity?: Date;
};

export function isATeamType(obj: any): obj is TeamType {
  return (
    obj &&
    typeof obj.id === "number" &&
    typeof obj.teamName === "string" &&
    typeof obj.customerId === "number" &&
    Array.isArray(obj.captainsId) &&
    obj.captainsId.every((id: number) => typeof id === "number") &&
    typeof obj.teamDescription === "string"
  );
}

export type CaptainDetails = {
  captainId: number;
  firstName: string;
  lastName: string;
};

export type TeamTypeOut = {
  captainsId: (number | null)[];
  teamName: string | null;
  customerId: number | null;
  teamDescription: string | null;
};
