import { UserService } from '../features/user/user.service';
import { UserRepository } from '../features/user/user.repository';
import { UserToRegisterIn } from '../features/user/toRegister.dtoIn';
import { UserInformationDto } from '../features/user/userInformations.dto';

jest.mock('../features/user/user.repository', () => {
  return {
    getUserById: jest.fn(),
    registerUser: jest.fn(),
  };
});

describe('UserService', () => {
  let userService: UserService;
  let userRepository: jest.Mocked<UserRepository>;
  beforeEach(() => {
    userRepository = {
      getUserById: jest.fn(),
      registerUser: jest.fn(),
      getByLogin: jest.fn(), // Add this line
    };
    userService = new UserService(userRepository);
  });

  describe('checkUserLoginDetails', () => {
    it('should register a user and return a response', async () => {
      const userToRegister = new UserToRegisterIn(
        'testLastName',
        'testFirstName',
        'testEmail',
        'testPassword'
      );
      userRepository.registerUser.mockResolvedValueOnce({
        id: 1,
        token: 'testToken',
      });

      const result = await userService.registerUser(userToRegister);
      console.log(result);
      expect(result.isRegistered).toBe(true);
    });
  });

  describe('registerUser', () => {
    it('should register a user and return a response', async () => {
      const userToRegister = new UserToRegisterIn(
        'testLastName',
        'testFirstName',
        'testEmail',
        'testPassword'
      );
      userRepository.registerUser.mockResolvedValueOnce({
        id: 1,
        token: 'testToken',
      });

      const result = await userService.registerUser(userToRegister);
      expect(result.isRegistered).toBe(true);
    });
  });

  describe('getUserById', () => {
    it('should return a user by id', async () => {
      const testUserId = 1;
      const expectedUser: UserInformationDto = {
        lastname: 'testLastName',
        firstname: 'testFirstName',
        email: 'testEmail',
      };
      userRepository.getUserById.mockResolvedValueOnce(expectedUser);

      const result = await userService.getUserById(testUserId);

      expect(result).toEqual(expectedUser);
    });

    // Add more test cases as needed
  });
});
