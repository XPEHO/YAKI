export class CaptainDtoOut {
    captain_id: number
    user_id: number
    last_name: string
    first_name: string
    email: string

    constructor(
        captain_id: number,
        user_id: number,
        last_name: string,
        first_name: string,
        email: string
    ) {
        this.captain_id = captain_id;
        this.user_id = user_id;
        this.last_name = last_name;
        this.first_name = first_name;
        this.email = email;
    }
}