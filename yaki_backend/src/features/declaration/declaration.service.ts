import { DeclarationRepository } from './declaration.repository';
import { Declaration } from './declaration.interface';
import { StatusDeclaration } from './status.enum';

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
    if (declaration.declaration_team_mate_id
      && declaration.declaration_date
      && declaration.declaration_status !== undefined
      && declaration.declaration_status.trim() !== '' ) 
         {
      return await this.declarationRepository.createDeclaration(declaration);
    } else {
      throw new Error("One or more mandatory information is missing.")
    }
  }

  // return {
  //   statusCode: 400,
  //   body: "One or more mandatory information is missing.",
  // }
}