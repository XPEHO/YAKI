export class PasswordChangeDtoIn {
  userId: number;
  currentPassword: string;
  newPassword: string;

  constructor(userId: number, currentPassword: string, newPassword: string) {
    this.userId = userId;
    this.currentPassword = currentPassword;
    this.newPassword = newPassword;
  }
}
