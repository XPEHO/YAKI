import { DeclarationRepository } from './declaration.repository';
import { DeclarationDtoIn } from './declaration.dtoIn';

export class DeclarationService {
  private declarationRepository: DeclarationRepository;

  /**
 * Creates a new instance of DeclarationService.
 * @param declarationRepository The DeclarationRepository instance to be used by this service.
 */
  constructor(declarationRepository: DeclarationRepository) {
    this.declarationRepository = declarationRepository
  }

  /**
   * This function creates a declaration and returns the created declaration.
   * @param {Declaration} declaration - Declaration
   * @returns The declaration object.
   */
  async createDeclaration(declaration: DeclarationDtoIn) {
    if (declaration.declarationTeamMateId
      && declaration.declarationDate
      && declaration.declarationStatus !== undefined
      && declaration.declarationStatus.trim() !== '' ) 
         {
      return await this.declarationRepository.createDeclaration(declaration);
    } else {
      throw new TypeError("One or more mandatory information is missing.")
    }
  }

  /**
   * Get all declarations for a team mate and return them, if there are none, return a string
   * @param {number} teamMateId - number
   * @returns An array of declarations or a string.
   */
  async getDeclarationsForTeamMate(teamMateId: number): Promise<Declaration[] | String> {
    const declarations = await this.declarationRepository.getDeclarationsForTeamMate(teamMateId);
    if (declarations.length > 0) {
      return declarations;
    } else {
      throw new Error("You have to declare yourself")
    }
  }

  /**
   * This function updates the status of a declaration.
   * @param {number} declarationId - number,
   * @param {Declaration} declaration - Declaration
   * @returns The declarationRepository.updateDeclarationStatus() ;.
   */
  async updateDeclarationStatus(
    declarationId: number,
    declaration: Declaration,
  ): Promise<void> {
    const existingDeclaration = await this.declarationRepository.getDeclarationById(declarationId);
    if (!existingDeclaration) {
      throw new Error("The declaration does not existe.");
    }
    return this.declarationRepository.updateDeclarationStatus(declarationId, declaration);
  }
}