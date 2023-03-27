import { UserService } from "../features/user/user.service";
import { UserRepository } from "../features/user/user.repository";
import mockDb from "./__mocks__/user";
import UserModel from "../features/user/user.dtoIn";
import { TeamMateDtoOut } from "../features/teamMate/teamMate.dtoOut";
import { CaptainDtoOut } from "../features/captain/captain.dtoOut";
import dbMockup from "./__mocks__/user";
import UserModel from "../features/user/user.dtoIn";

jest.mock('../features/user/user.repository', () => {
    return {
        UserRepository: jest.fn().mockImplementation(() => {
            return {
                getByLogin: (login: string) : UserModel => {
                    const user = dbMockup.filter(elm => elm.user_login == login);
                    if(user == null) {
                        throw new Error('Bad authentification details');
                    }
                    return user[0];
                }
            }
        })
    }
});

test("it should pass", async () => {
    expect(true).toBe(true);
  });


jest.mock('../features/user/user.repository', () => {
    return {
        UserRepository: jest.fn().mockImplementation(() => {
            return {
                getByLogin: (login: string) : UserModel => {
                    const user = mockDb.filter(elm => elm.user_login == login);
                    return user[0];
                }
            }
        })
    }
});


const mockedUserRepo = jest.mocked(UserRepository, {shallow: true});

describe('check login details', () => {
    // Initialize userService and UserRepository
    const useRepo = new UserRepository();
    const userService = new UserService(useRepo);

    // Reset all informations stored in jest mockup

jest.mock('../features/user/user.service', () => {
    return {
        UserService: jest.fn().mockImplementation(() => {
            // initialize user repository
            const userRepo = new UserRepository();
            return {
                checkUserLoginDetails: (object: any) => {
                    // doesn't work yet
                    const user : UserModel = userRepo.getByLogin(object.login);
                }
            }
        })
    }
})

describe('check login details', () => {

    beforeEach(() => {
        mockedUserRepo.mockClear();
    })

    it('return a captain', () => {
        const userRepo = new UserRepository();
        expect
    })
})

// const mockedUserRepo = jest.mocked(UserRepository, {shallow: true});

describe('check login details', () => {
    const useRepo = new UserRepository();
    const userService = new UserService(useRepo);
    beforeEach(() => {
        mockedUserRepo.mockClear();
    })


    it('return a captain', async () => {
        expect(await userService.checkUserLoginDetails({login: 'lavigne', password: 'lavigne'})).toBeInstanceOf(CaptainDtoOut);
    })

    it('return a team mate', async () => {
        expect(await userService.checkUserLoginDetails({login: 'dugrand', password: 'dugrand'})).toBeInstanceOf(TeamMateDtoOut);
    } )



    it("login is good but not password", () => {
        expect(userService.checkUserLoginDetails({login: 'lavigne', password: 'lavign'})).rejects.toThrowError('Bad authentification details');
    })
})

