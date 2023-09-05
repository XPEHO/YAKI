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
   * @param arr list containing all objects to insert, will determine row(s) count.
   * @param obj object to be inserted in a row, will determine values count to be saved ( columns ).
   * @param startValue query VALUES start value.
   * @returns query VALUE string : ($1, $2...), ($x, $y...),...
   */
  static queryValuesString(arr: Array<any>, obj: object, startValue: number): string {
    if (!arr || !obj) {
      throw new TypeError("data is requiered to create the query VALUES string");
    }
    // amount of object in the array ( row count )
    const objectCount: number = arr.length;
    // values count per object ( columns )
    const valuesCount: number = Object.values(obj).length;

    if (objectCount < 1 || valuesCount < 1) {
      throw new TypeError("No data to create the query VALUES string");
    }

    const rows: Array<string> = Array(objectCount).fill("0");
    const columns: Array<string> = Array(valuesCount).fill("0");

    const postgresValues = rows
      .map(() => {
        const values = columns.map(() => `$${startValue++}`).join(", ");
        return "(" + values + ")";
      })
      .join(", ");

    return postgresValues;
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
}
