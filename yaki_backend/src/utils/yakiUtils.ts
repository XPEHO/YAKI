import {AvatarDto} from "../features/user/avatar.dto";
import {AvatarEnum} from "../features/user/avatar.enum";
import fs from "fs";
import * as path from "path";

export default class YakiUtils {
  /**
   * Transform a object list into a flat array containing only the objects values.
   * @param objectList
   * @returns Array<String>
   */
  static objectsListToValuesList(objectList: Array<object>): Array<string> {
    const flatValuesList = objectList
      .map((obj) => {
        return Object.values(obj);
      })
      .flat();
    return flatValuesList;
  }

  /**
   *  Check if the data passed as argument is an object
   * @param toTest data to test
   * @returns boolean
   */
  static isAnObject(toTest: any): boolean {
    return typeof toTest === "object" && !Array.isArray(toTest) && toTest !== null;
  }

  /**
   * Check if 2 objects have the same attributes count. And if attributes are the same.
   * Prevent duck typing
   *
   * Return a boolean value
   * @param obj1 Object
   * @param obj2 Object
   * @returns true or false.
   */
  static isSameObjStructure(obj1: object, obj2: object): boolean {
    // if data aren't object
    if (!this.isAnObject(obj1) || !this.isAnObject(obj2)) {
      throw new TypeError("incorrect data");
    }
    // create arrays containing objects attributes (keys) as values
    const obj1Attr = Object.keys(obj1);
    const obj2Attr = Object.keys(obj2);
    // if empty object
    if (obj1Attr.length === 0 || obj2Attr.length === 0) {
      throw new TypeError("No data");
    }
    // else check if objects have the sames attributes & attributes count
    return obj1Attr.length === obj2Attr.length && obj1Attr.every((key, index) => key === obj2Attr[index]);
  }

  /**
   * Sets the time of the given date to 00:00:00.
   * @param {Date} date - The date to set the time to 00:00:00.
   * @returns {Date} A new Date object with the time set to 00:00:00.
   */
  static setToDateWithoutTime(date: Date): Date {
    const dateStr = date.toString().split("T")[0];
    const dateNoTime = new Date(dateStr);

    return dateNoTime;
  }

  /**
   * Returns a new Date object with the time set to 00:00:00 of the current day.
   * @returns {Date} A new Date object with the time set to 00:00:00 of the current day.
   */
  static todayDateOnly(): Date {
    const today = new Date();
    const todayNoTime = new Date(today.getFullYear(), today.getMonth(), today.getDate());

    return todayNoTime;
  }

  /**
   * Convert a bytea to a picture file.
   * It will either be a svg or a jpg file, depending of the avatar reference.
   * @param avatarData
   * @returns
   */
  static byteaToPicture = (avatarData: AvatarDto) => {
    let fileExtension;
    if (avatarData.avatarReference !== AvatarEnum.USERPICTURE) {
      fileExtension = ".svg";
    } else if (avatarData.avatarReference === AvatarEnum.USERPICTURE) {
      fileExtension = ".jpg";
    }

    // Convert byte array to Buffer
    const buffer = Buffer.from(avatarData.avatarBlob);
    // Write Buffer to file
    const filePath = path.join(__dirname, `avatar${fileExtension}`);
    fs.writeFileSync(filePath, buffer);
    return filePath;
  };
}
