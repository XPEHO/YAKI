import { DeclarationRepository } from './declaration.repository';
import { Declaration } from './declaration.interface';

export class DeclarationService {
  private declarationsRepository: DeclarationRepository;

  constructor() {
    this.declarationsRepository = new DeclarationRepository();
    // this.declarationsRepository= declarationsRepository
  }
  async createDeclaration(declaration: Declaration): Promise<Declaration> {
    
    return this.declarationsRepository.createDeclaration(declaration);
    
  }
  // constructor(private declarationRepository: DeclarationRepository) {}

  /**
 * This async function creates a declaration by calling the create method of the declarationsRepository object.
 * If a declaration already exists for the given teammate with the same status, it returns the existing declaration.
 * @param {Declaration} declaration - The declaration object to create.
 * @returns {Promise<Declaration>} A promise that resolves to the created declaration.
 */
  // async createDeclaration(declaration: Declaration): Promise<Declaration> {
  //   const existingDeclaration = await this.declarationsRepository.findByTeammate(
  //     declaration.declaration_team_mate_id,
  //   );
  //   if (existingDeclaration.length > 0 && existingDeclaration[0].status === declaration.status) {
  //     return existingDeclaration[0];
  //   }
  //   return this.declarationsRepository.create(declaration);
  // }

  // async findDeclarationByTeammate(teamMateId: number): Promise<Declaration[]> {
  //   // Retrieve all declaration records for a given teammate ID from the database table
  //   return this.declarationsRepository.findByTeammate(teamMateId);
  // }


//   async getLatestDeclaration(idTeammate: number): Promise<Declaration> {
//     const declarations = await this.declarationsRepository.findByTeammate(idTeammate);
//     return declarations.length > 0 ? declarations[0] : null;
//   }
}