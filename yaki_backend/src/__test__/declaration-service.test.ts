import { DeclarationService } from '../features/declaration/declaration.service';
import { DeclarationDtoIn } from '../features/declaration/declaration.dtoIn';
import { StatusDeclaration } from '../features/declaration/status.enum';
import { DeclarationRepository } from "../features/declaration/declaration.repository";

describe("DeclarationService", () => {
  let declarationService: DeclarationService;
  let declarationRepository: DeclarationRepository;

  beforeEach(() => {
    declarationRepository = new DeclarationRepository();
    declarationService = new DeclarationService(declarationRepository);
  });
  describe('create a declaration ', () => {
    const declarationDtoIn: DeclarationDtoIn = new DeclarationDtoIn(
      1,
      1,
      new Date(),
      StatusDeclaration.REMOTE
    )

    it('should create and return a new declaration', async () => {
      jest.spyOn(declarationRepository, "createDeclaration").mockResolvedValueOnce(declarationDtoIn);

      const createdDeclaration = await declarationService.createDeclaration(declarationDtoIn);

      expect(createdDeclaration).toEqual(declarationDtoIn);
    })

    it("should throw a TypeError if mandatory information is missing", async () => {
      const declaration: any = {
        declarationId: 1,
        declarationTeamMateId: undefined,
        declarationDate: new Date,
        declarationStatus: '',
      };
      await expect(declarationService.createDeclaration(declaration)).rejects.toThrow(TypeError);
    })
  })
})