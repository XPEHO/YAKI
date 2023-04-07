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
   * Create the string used for postGres INSERT query VALUES string.
   * Use complete values list to insert to determine VALUES count.
   * (*Need to convert any object or Array<object> into flat values list*)
   *
   * And reference obj to determine how many rows to insert.
   *
   *  *Check if reach array end to break loop, before step check.*
   *  *Prevent to add "()" at string end in situations where arr.length % step === 0*
   * @param arr reference list to produces VALUES
   * @param obj reference object
   * @returns string like : ($1, $2...), ($x, $y...),...
   */
  static createInsertValues(arr: Array<any>, obj: object): string {
    const arrLength: number = arr.length;
    if (arrLength === 0) {
      return "";
    }

    const step: number = Object.values(obj).length;
    let postgresValues: string = "(";

    for (let i = 1; i <= arrLength; i++) {
      postgresValues += "$" + i;

      if (i % step !== 0 && i !== arrLength) {
        postgresValues += ", ";
      }

      if (i === arrLength) {
        postgresValues += ")";
        break;
      }

      if (arrLength > 1) {
        if (i % step === 0) {
          postgresValues += "), (";
        }
      }
    }

    return postgresValues;
  }
}
