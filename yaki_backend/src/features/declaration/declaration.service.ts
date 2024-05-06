import {DeclarationRepository} from "./declaration.repository";
import {DeclarationDtoIn} from "./declaration.dtoIn";
import {StatusDeclaration} from "./status.enum";
import YakiUtils from "../../utils/yakiUtils";
import {DeclarationDto} from "./declaration.dto";

export class DeclarationService {
  private declarationRepository: DeclarationRepository;

  /**
   * Creates a new instance of DeclarationService.
   * @param declarationRepository The DeclarationRepository instance to be used by this service.
   */
  constructor(declarationRepository: DeclarationRepository) {
    this.declarationRepository = declarationRepository;
  }

  /**
   * This function creates a declaration and returns the created declaration.
   * @param {DeclarationDtoIn} declarationList - Declaration
   * @returns The declaration object.
   */
  async createDeclaration(declarationList: DeclarationDto[]) {
    if (declarationList.length !== 1) {
      throw new TypeError("Incorrect full day declaration data, must contain one object only");
    }
    if (!Object.values(StatusDeclaration).includes(declarationList[0].declarationStatus)) {
      throw new TypeError("Invalid declaration status.");
    }

    const reference = new DeclarationDto(
      0,
      new Date(),
      new Date(),
      new Date(),
      StatusDeclaration.ON_SITE,
      0
    );
    if (YakiUtils.isSameObjStructure(declarationList[0], reference) === false) {
      throw new TypeError("Incorrect data");
    }

    if (
      declarationList[0].declarationUserId &&
      declarationList[0].declarationDate &&
      declarationList[0].declarationDateStart &&
      declarationList[0].declarationDateEnd &&
      declarationList[0].declarationStatus !== undefined &&
      declarationList[0].declarationStatus.trim() !== ""
    ) {
      const dateStart = YakiUtils.setToDateWithoutTime(
        declarationList[0].declarationDateStart
      );
      const dateEnd = YakiUtils.setToDateWithoutTime(declarationList[0].declarationDateEnd);
      const today = YakiUtils.todayDateOnly();

      // If all check are true : declaration is for one day, and its made for the current date
      // if any of the check is false, it mean its scheduled absence for the future
      // an absence created for the current day will be considered as the latest declaration
      if (
        dateStart.getTime() === dateEnd.getTime() &&
        dateStart.getTime() === today.getTime()
      ) {
        // unflag from true to false the preview "latest" declaration
        await this.declarationRepository.unflagLatestDeclaration(
          declarationList[0].declarationUserId
        );
        return await this.declarationRepository.createDeclaration(declarationList, true);
      }
      // Here : create an absence for the future OR/AND with a duration of more than one day
      return await this.declarationRepository.createDeclaration(declarationList, false);
    } else {
      throw new TypeError("One or more mandatory information is missing.");
    }
  }

  /**
   * Function to save into the database the half day declaration.
   *
   * Check if each declaration status match the statusDeclaration enum, if not throw Error
   *
   * Check if each values from each objects arent either null, undefined, or empty string. if so throw error,
   * else invoke repository function to save data in the database
   *
   * It return the saved declaration as DtoIn list.
   * @param declarationList List containing morning and afternoon declaration objects
   * @returns Array containing saved halfday declaration object
   */
  async createHalfDayDeclarations(declarationList: DeclarationDto[]) {
    if (declarationList.length !== 2) {
      throw new TypeError("Incorrect half day declaration data, must contain 2 object");
    }
    for (let declaration of declarationList) {
      // object.values : array containing keys.
      if (!Object.values(StatusDeclaration).includes(declaration.declarationStatus)) {
        throw new TypeError("Invalid declaration status.");
      }
    }

    for (let declaration of declarationList) {
      const reference = new DeclarationDto(
        0,
        new Date(),
        new Date(),
        new Date(),
        StatusDeclaration.ON_SITE,
        0
      );
      if (YakiUtils.isSameObjStructure(declaration, reference) === false) {
        throw new TypeError("Incorrect data");
      }
    }

    let isObjectsValid: boolean = false;
    for (let declaration of declarationList) {
      // check  if all values are true, therefore  no null, nor undefined, nor empty string.
      if (
        declaration.declarationUserId &&
        declaration.declarationDate &&
        declaration.declarationDateStart &&
        declaration.declarationDateEnd &&
        declaration.declarationStatus !== undefined &&
        declaration.declarationStatus.trim() !== ""
      ) {
        isObjectsValid = true;
      }
      // break loop at the first false value ( found unexpected data )
      if (!isObjectsValid) break;
    }
    if (!isObjectsValid) {
      throw new TypeError("One or more requiered information is missing.");
    }
    // unflag from true to false the preview "latest" declaration
    await this.declarationRepository.unflagLatestDeclaration(
      declarationList[0].declarationUserId
    );

    return await this.declarationRepository.createHalfDayDeclaration(declarationList, true);
  }

  /**
   * Get all declarations for a team mate.
   * @param {number} userId - number
   * @returns DeclarationDtoIn[] | String
   */
  async getLatestDeclarationByUserId(userId: number): Promise<DeclarationDtoIn[] | string> {
    const declarationList: DeclarationDtoIn[] =
      await this.declarationRepository.getLatestDeclarationByUserId(userId);
    if (
      declarationList.length !== 0 ||
      declarationList !== null ||
      declarationList !== undefined
    ) {
      return this.selectDeclarationToReturn(declarationList);
    } else {
      throw new TypeError("You have to declare yourself.");
    }
  }

  /**
   * Function returning either daily declaration or both halfday declaration.
   *
   * Use declarationList sorted by the declaration time, the lastest resgistered declaration is the first array element.
   *
   * Check if the first element is a full day declaration based on start and end hours.
   * If not, find the first morning and afternoon declaration and add them in order to the array,
   * that will be returned
   * @param declarationList declarations of the current day coming from sql request
   * @returns declarationList to return to be to the front.
   */
  selectDeclarationToReturn = (declarationList: DeclarationDtoIn[]): DeclarationDtoIn[] => {
    const listToReturn: DeclarationDtoIn[] = [];
    if (declarationList.length === 0) {
      throw new TypeError("No declaration to send");
    }
    const hourStart = declarationList[0].declarationDateStart.getHours();
    const hourEnd = declarationList[0].declarationDateEnd.getHours();

    const dayStart = declarationList[0].declarationDateStart.toDateString();
    const dayEnd = declarationList[0].declarationDateEnd.toDateString();

    // check for same day declaration
    // if not can be absence that could requier for more than on day.
    if (dayStart == dayEnd) {
      // check if first declaration for the day is daily declaration.
      // if not necessary halfDay declaration.
      if (hourStart < 9 && hourEnd > 15) {
        listToReturn.push(declarationList[0]);
      } else {
        const morning: DeclarationDtoIn | undefined = declarationList.find(
          (declaration) => declaration.declarationDateEnd.getHours() < 13
        );
        const afternoon: DeclarationDtoIn | undefined = declarationList.find(
          (declaration) => declaration.declarationDateStart.getHours() > 12
        );

        if (morning !== undefined && afternoon !== undefined) {
          listToReturn.push(morning, afternoon);
        } else {
          throw new TypeError("Missing a half day declaration");
        }
      }
    } else {
      listToReturn.push(declarationList[0]);
    }
    return listToReturn;
  };
}
