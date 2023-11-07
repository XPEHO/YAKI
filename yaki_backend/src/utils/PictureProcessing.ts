import fs from "fs";
import * as path from "path";

export default class PictureProcessing {
  /**
   * Convert a bytea to a picture file.
   * It will either be a svg or a jpg file, depending of the avatar reference.
   * @param avatarData
   * @returns
   */
  static byteaToImage = (avatar: Buffer) => {
    // Convert byte array to Buffer
    const buffer = Buffer.from(avatar);
    // Write Buffer to file
    const filePath = path.join(__dirname, `avatar.jpg"}`);
    fs.writeFileSync(filePath, buffer);
    return filePath;
  };

  /**
   * Delete a file upload by Multer once the necessary process is done
   * @param file
   */
  static deleteUploadedFile = (file: any) => {
    fs.unlink(file.path, (err) => {
      if (err) {
        console.error("Error deleting file:", err);
      }
    });
  };
}
