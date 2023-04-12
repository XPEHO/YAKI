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

  describe("updateDeclarationStatus", () => {
    /* This test is checking if the declarationService.updateDeclarationStatus method throws a TypeError
   if the declaration does not exist. */
    it("should throw an error if declaration does not exist", async () => {
      const declarationId = 1;
      const declaration: any = {
        declarationTeamMateId: 1,
        declarationDate: new Date(),
        declarationStatus: StatusDeclaration.REMOTE,
      };
      jest.spyOn(declarationRepository, "getDeclarationById").mockResolvedValueOnce(Promise.resolve<any>(null));

      await expect(declarationService.updateDeclarationStatus(declarationId, declaration)).rejects.toThrow(TypeError);
    });
  });

  /* This test is checking if the declarationService.updateDeclarationStatus method throws a TypeError
  if mandatory information is missing. */
  it("should throw an error if mandatory information is missing", async () => {
    const declarationId = 1;
    const declaration: any = {
      declarationId: 1,
      declarationTeamMateId: null,
      declarationDate: null,
      declarationStatus: "",
    };
    jest.spyOn(declarationRepository, "getDeclarationById").mockResolvedValueOnce({
      declarationId: 1,
      declarationTeamMateId: 1,
      declarationDate: new Date(),
      declarationDateStart: new Date(),
      declarationDateEnd: new Date(),
      declarationStatus: StatusDeclaration.REMOTE,
    });

    await expect(declarationService.updateDeclarationStatus(declarationId, declaration)).rejects.toThrow(TypeError);
  });

  /* This test is checking if the declarationService.updateDeclarationStatus method throws a TypeError
    if the declaration status is invalid. */
  it("should throw an error if declaration status is invalid", async () => {
    const declarationId = 1;
    const declaration: any = {
      declarationId: 1,
      declarationTeamMateId: 1,
      declarationDate: new Date(),
      declarationDateStart: new Date(),
      declarationDateEnd: new Date(),
      declarationStatus: "INVALID_STATUS",
    };
    jest.spyOn(declarationRepository, "getDeclarationById").mockResolvedValueOnce({
      declarationId: 1,
      declarationTeamMateId: 1,
      declarationDate: new Date(),
      declarationDateStart: new Date(),
      declarationDateEnd: new Date(),
      declarationStatus: StatusDeclaration.REMOTE,
    });

    await expect(declarationService.updateDeclarationStatus(declarationId, declaration)).rejects.toThrow(TypeError);
  });

  /* This test is checking if the declarationService.updateDeclarationStatus method updates the
  declaration status successfully. */
  it("should update the declaration status successfully", async () => {
    const declarationId = 1;
    const declaration: DeclarationDtoIn[] = [
      {
        declarationId: 1,
        declarationTeamMateId: 1,
        declarationDate: new Date(),
        declarationDateStart: new Date(),
        declarationDateEnd: new Date(),
        declarationStatus: StatusDeclaration.REMOTE,
      },
    ];
    const existingDeclaration = {
      declarationId: 1,
      declarationTeamMateId: 1,
      declarationDate: new Date(),
      declarationDateStart: new Date(),
      declarationDateEnd: new Date(),
      declarationStatus: StatusDeclaration.ON_SITE,
    };

    const updateDeclarationSpy = jest
      .spyOn(declarationRepository, "updateDeclarationStatus")
      .mockResolvedValue(undefined);
    jest.spyOn(declarationRepository, "getDeclarationById").mockResolvedValue(existingDeclaration);

    await declarationService.updateDeclarationStatus(declarationId, declaration);

    expect(updateDeclarationSpy).toHaveBeenCalledWith(declarationId, declaration);
  });

  describe("get a declaration ", () => {
    const declarationDtoIn: DeclarationDtoIn[] = [
      new DeclarationDtoIn(
        1,
        1,
        new Date(),
        new Date(new Date().setHours(6)),
        new Date(new Date().setHours(18)),
        StatusDeclaration.REMOTE
      ),
    ];

    it("should get and return declaration of teamMate 1", async () => {
      jest.spyOn(declarationRepository, "getDeclarationForTeamMate").mockResolvedValueOnce(declarationDtoIn);

      const declarationForTeamMates = await declarationService.getDeclarationForTeamMate(1);

      expect(declarationForTeamMates).toEqual(declarationDtoIn);
    });
  });
});
