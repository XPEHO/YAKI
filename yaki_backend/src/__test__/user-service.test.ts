import { UserService } from "../features/user/user.service";
import { UserRepository } from "../features/user/user.repository";
import mockDb from "./__mocks__/mockDbUsers";
import UserModel from "../features/user/user.dtoIn";
import { CaptainDtoOut } from "../features/captain/captain.dtoOut";
import { TeammateDtoOut } from "../features/teammate/teammate.dtoOut";
import { UserToRegisterIn } from "../features/user/toRegister.dtoIn";

// Mock of UserRepository
jest.mock("../features/user/user.repository", () => {
  return {
    UserRepository: jest.fn().mockImplementation(() => {
      return {
        getByLogin: (login: string): UserModel => {
          const user = mockDb.filter((elm) => elm.user_login == login);
          return user[0];
        },
      };
    }),
  };
});

const mockedUserRepo = jest.mocked(UserRepository, { shallow: true });

describe("check login details", () => {
  // Initialize userService and UserRepository
  const useRepo = new UserRepository();
  const userService = new UserService(useRepo);

  // Reset all informations stored in jest mockup
  beforeEach(() => {
    mockedUserRepo.mockClear();
  });

  it("return a captain", async () => {
    expect(
      await userService.checkUserLoginDetails({
        login: "lavigne",
        password: "lavigne",
      })
    ).toBeInstanceOf(CaptainDtoOut);
  });

  it("return a team mate", async () => {
    expect(
      await userService.checkUserLoginDetails({
        login: "dugrand",
        password: "dugrand",
      })
    ).toBeInstanceOf(TeammateDtoOut);
  });

  it("login is good but not password", () => {
    expect(
      userService.checkUserLoginDetails({
        login: "lavigne",
        password: "wrongpassword",
      })
    ).rejects.toThrowError("Bad authentification details");
  });

  describe("UserService", () => {
    let userService: UserService;
    let userRepository: UserRepository;

    beforeEach(() => {
      userRepository = new UserRepository();
      userService = new UserService(userRepository);
    });

    describe("resetPassword", () => {
      it("should reset the password for a user", async () => {
        //Arrange
        const user = new UserToRegisterIn(
          "Arthur",
          "Lupine",
          "arthurlupine@example.com",
          "password"
        );
        const expectedResponse = true;

        //Act
        const response = await userService.resetPassword(user);

        //Assert
        expect(response).toEqual(expectedResponse);
      });
      it("should thro an error if the user data is incorrect", async () => {
        //Arrange
        const user = new UserToRegisterIn("", "", "", "");

        //Act and Assert
        await expect(userService.resetPassword(user)).rejects.toThrowError(
          "Incorrect data"
        );
      });

      it("should throw an error if the user data is missing", async () => {
        //Arrange
        const user = new UserToRegisterIn("", "", "", "password");

        //Act and Assert
        await expect(userService.resetPassword(user)).rejects.toThrowError(
          "Missing registration information(s)"
        );
      });

      it("should throw an error if the password reset failed", async () => {
        //Arrange
        const user = new UserToRegisterIn(
          "Arthur",
          "Lupine",
          "arthurlupine@exemple.com",
          "password"
        );

        jest
          .spyOn(userRepository, "resetPassword")
          .mockRejectedValueOnce(new Error("Password reset failed"));

        //Act and Assert
        await expect(userService.resetPassword(user)).rejects.toThrowError(
          "Password reset failed"
        );
      });
    });
  });
});
