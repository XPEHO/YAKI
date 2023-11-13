import fs from "fs";

export default class PictureProcessing {
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
