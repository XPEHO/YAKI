import {Declaration} from "./declaration.interface";
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
  async createDeclaration(declaration: DeclarationDtoIn) {
    if (!Object.values(StatusDeclaration).includes(declaration.declarationStatus)) {
      throw new TypeError("Invalid declaration status.");
    }
    if (
      declaration.declarationTeamMateId &&
      declaration.declarationDate &&
      declaration.declarationDateStart &&
      declaration.declarationDateEnd &&
      declaration.declarationStatus !== undefined &&
      declaration.declarationStatus.trim() !== ""
    ) {
      return await this.declarationRepository.createDeclaration(declaration);
    } else {
      throw new TypeError("One or more mandatory information are missing.");
    }
  }

  /**
   *
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
      isObjectValid = Object.values(declaration).every((value) => value);
    }

    if (isObjectValid) {
      return await this.declarationRepository.createHalfDayDeclaration(DeclarationList);
    } else {
      throw new TypeError("One or more mandatory information are missing.");
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
