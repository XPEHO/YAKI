import { DeclarationRepository } from './declaration.repository';
import { Declaration } from './declaration.interface';

export class DeclarationService {
  private declarationsRepository: DeclarationRepository;

  constructor() {
    this.declarationsRepository = new DeclarationRepository();
  }

  async createDeclaration(declaration: Declaration): Promise<Declaration> {
    const existingDeclaration = await this.declarationsRepository.findByTeammate(
      declaration.declaration_team_mate_id,
    );
    if (existingDeclaration.length > 0 && existingDeclaration[0].status === declaration.status) {
      return existingDeclaration[0];
    }
    return this.declarationsRepository.create(declaration);
  }

  async getLatestDeclaration(idTeammate: number): Promise<Declaration> {
    const declarations = await this.declarationsRepository.findByTeammate(idTeammate);
    return declarations.length > 0 ? declarations[0] : null;
  }
}