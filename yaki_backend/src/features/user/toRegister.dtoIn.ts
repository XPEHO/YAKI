export class UserToRegisterIn {
  lastname: string;
  firstname: string;
  email: string;
  password: string;

  constructor(lastname: string, firstname: string, email: string, password: string) {
    this.lastname = lastname;
    this.firstname = firstname;
    this.email = email;
    this.password = password;
  }
}
