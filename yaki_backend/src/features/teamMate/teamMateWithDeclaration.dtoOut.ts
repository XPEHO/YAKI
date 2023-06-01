import { StatusDeclaration } from "../declaration/status.enum"

export class TeamMateWithDeclaration {
    userId: number
    teamMateId: number
    userLastName: string
    userFirstName: string
    declarationDate: Date
    declarationStatus: StatusDeclaration

    constructor(
        userId: number,
        teamMateId: number,
        userLastName: string,
        userFirstName: string,
        declarationDate: Date,
        declarationStatus: StatusDeclaration
    ) {
        this.userId = userId;
        this.teamMateId = teamMateId;
        this.userLastName = userLastName;
        this.userFirstName = userFirstName;
        this.declarationDate = declarationDate;
        this.declarationStatus = declarationStatus;
    }
}