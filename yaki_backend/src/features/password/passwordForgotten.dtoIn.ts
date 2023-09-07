export class PasswordForgottenDtoIn {
  userId: number;
  email: string;
  newPassword: string;

  constructor(userId: number, email: string, newPassword: string) {
    this.userId = userId;
    this.email = email;
    this.newPassword = newPassword;
  }
}
