import { UserService } from "../features/user/user.service";
import { UserRepository } from "../features/user/user.repository";
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

const mockedUserRepo = jest.mocked(UserRepository, {shallow: true});

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
