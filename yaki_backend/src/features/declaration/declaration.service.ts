import {DeclarationRepository} from "./declaration.repository";
import {DeclarationDtoIn} from "./declaration.dtoIn";
import {StatusDeclaration} from "./status.enum";

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
   * @param {DeclarationDtoIn} declaration - Declaration
   * @returns The declaration object.
   */
  async createDeclaration(declaration: DeclarationDtoIn[]) {
    if (!Object.values(StatusDeclaration).includes(declaration[0].declarationStatus)) {
      throw new TypeError("Invalid declaration status.");
    }
    if (
      declaration[0].declarationTeamMateId &&
      declaration[0].declarationDate &&
      declaration[0].declarationDateStart &&
      declaration[0].declarationDateEnd &&
      declaration[0].declarationStatus !== undefined &&
      declaration[0].declarationStatus.trim() !== ""
    ) {
      return await this.declarationRepository.createDeclaration(declaration[0]);
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
   * @param DeclarationList List containing morning and afternoon declaration objects
   * @returns Array containing saved halfday declaration object
   */
  async createHalfDayDeclarations(DeclarationList: DeclarationDtoIn[]) {
    for (let declaration of DeclarationList) {
      // object.values : array containing keys.
      if (!Object.values(StatusDeclaration).includes(declaration.declarationStatus)) {
        throw new TypeError("Invalid declaration status.");
      }
    }
    let isObjectValid: boolean = false;
    for (let declaration of DeclarationList) {
      // check  if all values are true,  therefore  no null, nor undefined, nor empty string.
      isObjectValid = Object.values(declaration).every((value) => value.trim());
      // break loop at the first false value ( found unexpected data )
      if (!isObjectValid) break;
    }

    if (isObjectValid) {
      return await this.declarationRepository.createHalfDayDeclaration(DeclarationList);
    } else {
      throw new TypeError("One or more requiered information is missing.");
    }
  }

  /**
   * Get all declarations for a team mate.
   * @param {number} teamMateId - number
   * @returns DeclarationDtoIn | String
   */
  async getDeclarationForTeamMate(teamMateId: number): Promise<DeclarationDtoIn | String> {
    const declaration = await this.declarationRepository.getDeclarationForTeamMate(teamMateId);
    if (declaration !== null || declaration !== undefined) {
      return declaration;
    } else {
      throw new TypeError("You have to declare yourself.");
    }
  }

  /**
   * This function updates the status of a declaration.
   * @param {number} declarationId - number,
   * @param {DeclarationDtoIn} declaration - Declaration.
   * @returns The declarationRepository.updateDeclarationStatus() ;.
   */
  async updateDeclarationStatus(declarationId: number, declaration: DeclarationDtoIn): Promise<void> {
    const existingDeclaration = await this.declarationRepository.getDeclarationById(declarationId);
    if (!existingDeclaration) {
      throw new TypeError("The declaration does not existe.");
    }
    if (
      declaration.declarationTeamMateId === null ||
      declaration.declarationDate === null ||
      declaration.declarationDateStart === null ||
      declaration.declarationDateEnd === null ||
      declaration.declarationStatus.trim() === ""
    ) {
      throw new TypeError("One or more mandatory information is missing.");
    }
    if (!Object.values(StatusDeclaration).includes(declaration.declarationStatus)) {
      throw new TypeError("Invalid declaration status.");
    }
    return this.declarationRepository.updateDeclarationStatus(declarationId, declaration);
  }
}
