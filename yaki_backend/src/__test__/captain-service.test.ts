import { CaptainService } from '../features/captain/captain.service';
import { CaptainRepository } from '../features/captain/captain.repository';
import mockCaptain from './__mocks__/captain';
import { CaptainDtoIn } from '../features/captain/captain.dtoIn';

const mockedCaptainRepo = jest.mocked(CaptainRepository, { shallow: true });

jest.mock('../features/captain/captain.repository', () => {
  return {
    CaptainRepository: jest.fn().mockImplementation(() => {
      return {
        getByUserId: (user_id: number): CaptainDtoIn => {
          const user = mockCaptain.filter((elm) => elm.user_id == user_id);
          if (user_id == null) {
            throw new Error('Bad authentification details');
          }
          return user[0];
        },
        getAll: async () => {
          const captain = mockCaptain;
          return captain;
        },
      };
    }),
  };
});

describe('get captain by userId', () => {
  const captainRepo = new CaptainRepository();
  const captainService = new CaptainService(captainRepo);

  beforeEach(() => {
    mockedCaptainRepo.mockClear();
  });
  it('return a team mate', async () => {
    expect(await captainService.getByUserId('1')).toMatchObject({
      captain_id: 1,
      team_mate_user_id: 1,
      user_id: 1,
      user_last_name: 'Lavigne',
      user_first_name: 'Martin',
      user_email: 'lavigne.martin@gmail.com',
      user_login: 'lavigne',
      user_password: 'lavigne',
    });
  });
});

describe('get teammate by team id with last declaration', () => {
  const captainRepo = new CaptainRepository();
  const captainService = new CaptainService(captainRepo);

  beforeEach(() => {
    mockedCaptainRepo.mockClear();
  });

  it('return a team mate with last declaration', async () => {
    expect(await captainService.getAll()).toMatchObject([
      {
        captain_id: 1,
        team_mate_user_id: 1,
        user_id: 1,
        user_last_name: 'Lavigne',
        user_first_name: 'Martin',
        user_email: 'lavigne.martin@gmail.com',
        user_login: 'lavigne',
        user_password: 'lavigne',
      },
      {
        captain_id: 2,
        team_mate_user_id: 2,
        user_id: 2,
        user_last_name: 'Doe',
        user_first_name: 'John',
        user_email: 'doe.john@gmail.com',
        user_login: 'doe',
        user_password: 'doe',
      },
    ]);
  });
});
