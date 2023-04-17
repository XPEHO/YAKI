import {DeclarationService} from "../features/declaration/declaration.service";
import {DeclarationDtoIn} from "../features/declaration/declaration.dtoIn";
import {StatusDeclaration} from "../features/declaration/status.enum";
import {DeclarationRepository} from "../features/declaration/declaration.repository";

describe("DeclarationService", () => {
  let declarationService: DeclarationService;
  let declarationRepository: DeclarationRepository;

  /* Creating a new instance of the DeclarationRepository and DeclarationService before each test. */
  beforeEach(() => {
    declarationRepository = new DeclarationRepository();
    declarationService = new DeclarationService(declarationRepository);
  });

  /* The above code is testing the declarationService.createDeclaration method. */
  describe("create a declaration ", () => {
    const declarationDtoIn: DeclarationDtoIn[] = [
      new DeclarationDtoIn(1, 1, new Date(), new Date(), new Date(), StatusDeclaration.REMOTE),
    ];

    /* This test is checking if the declarationService.createDeclaration method returns a new
    declaration. */
    it("should create and return a new declaration", async () => {
      jest.spyOn(declarationRepository, "createDeclaration").mockResolvedValueOnce(declarationDtoIn);

      const createdDeclaration = await declarationService.createDeclaration(declarationDtoIn);

      expect(createdDeclaration).toEqual(declarationDtoIn);
    });

    /* This test is checking if the declarationService.createDeclaration method throws a TypeError if
    mandatory information is missing. */
    it("should throw a TypeError if mandatory information is missing", async () => {
      const declaration: any = {
        declarationId: 1,
        declarationTeamMateId: undefined,
        declarationDate: new Date(),
        declarationStatus: "",
      };
      await expect(declarationService.createDeclaration(declaration)).rejects.toThrow(TypeError);
    });
  });

  describe("get a declaration ", () => {
    const dateStart: Date = new Date(new Date().setHours(6));
    const dateEnd: Date = new Date(new Date().setHours(18));

    const declarationDtoIn: DeclarationDtoIn[] = [
      new DeclarationDtoIn(1, 1, new Date(), dateStart, dateEnd, StatusDeclaration.REMOTE),
    ];

    it("should get and return declaration of teamMate 1", async () => {
      jest.spyOn(declarationRepository, "getDeclarationForTeamMate").mockResolvedValueOnce(declarationDtoIn);

      const declarationForTeamMates = await declarationService.getDeclarationForTeamMate(1);

      expect(declarationForTeamMates).toEqual(declarationDtoIn);
    });

    it("should throw an error for null or undefined declaration list", async () => {
      // Arrange
      const teamMateId = 1;

      jest.spyOn(declarationRepository, "getDeclarationForTeamMate").mockResolvedValueOnce([]);

      // Act and Assert
      await expect(declarationService.getDeclarationForTeamMate(teamMateId)).rejects.toThrow(TypeError);
    });
  });
});
