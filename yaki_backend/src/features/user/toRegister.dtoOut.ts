export class UserToRegisterOut {
  lastname: string;
  firstname: string;
  login: string;
  email: string;
  password: string;

  constructor(lastname: string, firstname: string, login: string, email: string, password: string) {
    this.lastname = lastname;
    this.firstname = firstname;
    this.login = login;
    this.email = email;
    this.password = password;
  }
}
