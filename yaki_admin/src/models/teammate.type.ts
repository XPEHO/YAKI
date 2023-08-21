export type TeammateTypeIn = {
  id: number;
  teamId: number;
  userId: number;
};

export type TeammateTypeOut = {
  teamId: number;
  userId: number;
};

// should be changed to have constant attributes naming
// see teammate.service.ts, line 11
// see teamStore.ts, line 5 & 79
export type TeammateTypeResponse = {
  id: number;
  firstName: string;
  lastName: string;
  email: string;
  teamId: number;
  userId: number;
};

// should be changed to have constant attributes naming
// see teammate.service.ts, line 11
// see teamStore.ts, line 5 & 79
export class TeammateType {
  id: number;
  firstname: string;
  lastname: string;
  email: string;
  teamId: number;
  userId: number;

  constructor(id: number, firstname: string, lastname: string, email: string, teamId: number, userId: number) {
    this.id = id;
    this.firstname = firstname;
    this.lastname = lastname;
    this.email = email;
    this.teamId = teamId;
    this.userId = userId;
  }
}
