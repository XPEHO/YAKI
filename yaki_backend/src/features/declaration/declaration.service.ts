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
    return await this.declarationRepository.createDeclaration(declaration);
  }
}