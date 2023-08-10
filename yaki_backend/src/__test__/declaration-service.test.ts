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
      new DeclarationDtoIn(1, 1, new Date(), new Date(), new Date(), StatusDeclaration.REMOTE, 1),
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
        declarationTeammateId: undefined,
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
      new DeclarationDtoIn(1, 1, new Date(), dateStart, dateEnd, StatusDeclaration.REMOTE, 1),
    ];

    it("should get and return declaration of teammate 1", async () => {
      jest.spyOn(declarationRepository, "getDeclarationForTeammate").mockResolvedValueOnce(declarationDtoIn);

      const declarationForTeammates = await declarationService.getDeclarationForTeammate(1);

      expect(declarationForTeammates).toEqual(declarationDtoIn);
    });

    it("should throw an error for null or undefined declaration list", async () => {
      // Arrange
      const teammateId = 1;

      jest.spyOn(declarationRepository, "getDeclarationForTeammate").mockResolvedValueOnce([]);

      // Act and Assert
      await expect(declarationService.getDeclarationForTeammate(teammateId)).rejects.toThrow(TypeError);
    });
  });
});
