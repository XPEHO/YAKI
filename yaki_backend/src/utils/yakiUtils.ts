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
   *
   * @param arr list containing all objects to insert
   * @param obj reference object
   * @returns string like : ($1, $2...), ($x, $y...),...
   */
  static queryValuesString(arr: Array<any>, obj: object): string {
    if (!arr || !obj) {
      throw new TypeError("incorrect data to produce the query VALUES string");
    }
    // amount of object in the array
    const objectCount: number = arr.length;
    // values count per object.
    const valuesCount: number = Object.values(obj).length;

    if (objectCount === 0 || valuesCount === 0) {
      throw new TypeError("No data to insert in the database");
    }

    let startValue = 1;
    const rows = Array(objectCount).fill(0);
    const columns = Array(valuesCount).fill(0);

    const postgresValues = rows
      .map(() => {
        return `(${columns.map(() => `$${startValue++}`).join(", ")})`;
      })
      .join(", ");

    return postgresValues;
  }
}
