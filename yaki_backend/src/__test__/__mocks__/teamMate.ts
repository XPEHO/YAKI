import { TeamMateDtoOut } from '../../features/teamMate/teamMate.dtoOut';

const mockTeamMate: TeamMateDtoOut[] = [
  {
    teamMateId: 1,
    userId: 1,
    teamId: 1,
    lastName: 'Michel',
    firstName: 'GLAREF',
    email: 'michel.glaref@mail.com',
    token: undefined,
  },
];

jest.mock('../features/teamMate/teamMate.repository', () => {
  return {
    TeamMateRepository: jest.fn().mockImplementation(() => {
      return {
        getByUserId: (index: number) => {
          return mockTeamMate[index];
        },
      };
    }),
  };
});
