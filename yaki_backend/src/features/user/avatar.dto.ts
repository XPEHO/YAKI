import {AvatarEnum} from "./avatar.enum";

export class AvatarDto {
  avatarId: number;
  avatarUserId: number;
  avatarReference: AvatarEnum;
  avatarBlob: Buffer;
  avatarIsValidated: boolean;

  constructor(
    avatarId: number,
    avatarUserId: number,
    avatarReference: AvatarEnum,
    avatarBlob: Buffer,
    avatarIsValidated: boolean
  ) {
    this.avatarId = avatarId;
    this.avatarUserId = avatarUserId;
    this.avatarReference = avatarReference;
    this.avatarBlob = avatarBlob;
    this.avatarIsValidated = avatarIsValidated;
  }
}
