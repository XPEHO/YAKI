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
        // getAll: async () => {
        //   const teamMates = await mockCaptain.filter(
        //     (elm) => elm.team_mate_team_id == team_id
        //   );
        //   const teamMateWithDeclaration =
        //     await mockTeamMatesWithDeclaration.filter(
        //       (elm) => elm.team_mate_id == teamMates[0].team_mate_id
        //     );
        //   return teamMateWithDeclaration;
        // },
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

// describe('get teammate by team id with last declaration', () => {
//   const teamRepo = new TeamRepository();
//   const teamService = new TeamService(teamRepo);
//   const teamMateRepo = new TeamMateRepository();
//   const teamMateService = new TeamMateService(teamMateRepo, teamService);
//   beforeEach(() => {
//     mockedTeamRepo.mockClear();
//     mockedTeamMateRepo.mockClear();
//   });

//   it('return a team mate with last declaration', async () => {
//     expect(
//       await teamMateService.getByTeamIdWithLastDeclaration(1)
//     ).toMatchObject([
//       {
//         userId: 1,
//         teamMateId: 1,
//         userLastName: 'Dupuis',
//         userFirstName: 'Jean',
//         declarationDate: new Date('1996-12-23'),
//         declarationStatus: 'On site',
//       },
//     ]);
//   });
// });
