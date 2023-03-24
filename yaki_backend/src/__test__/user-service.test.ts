test("it should pass", async () => {
    expect(true).toBe(true);
  });

// import { UserService } from "../features/user/user.service";
// import { UserRepository } from "../features/user/user.repository";
// import dbMockup from "./__mocks__/user";
// import UserModel from "../features/user/user.dtoIn";

// jest.mock('../features/user/user.repository', () => {
//     return {
//         UserRepository: jest.fn().mockImplementation(() => {
//             return {
//                 getByLogin: (login: string) : UserModel => {
//                     const user = dbMockup.filter(elm => elm.user_login == login);
//                     if(user == null) {
//                         throw new Error('Bad authentification details');
//                     }
//                     return user[0];
//                 }
//             }
//         })
//     }
// });

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
