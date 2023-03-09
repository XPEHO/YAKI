import { DeclarationRepository } from './declaration.repository';
import { Declaration } from './declaration.interface';

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
  async createDeclaration(declaration: Declaration) {
    if ((declaration.declaration_team_mate_id
       && declaration.declaration_date
        && declaration.declaration_status) != null) {
      return await this.declarationRepository.createDeclaration(declaration);
    } else {
       throw new Error("One or more mandatory information is missing.")
    }
  }
  // async createDeclaration(declaration: Declaration) {
  //   return await this.declarationRepository.createDeclaration(declaration);
  // }
}