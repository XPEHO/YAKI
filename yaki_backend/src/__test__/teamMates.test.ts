import { TeamMateRepository } from '../features/teamMate/teamMate.repository';

describe('test teamMate', () => {
  const MockedTeamRepo = jest.mocked(TeamMateRepository, { shallow: true });
  beforeEach(() => {
    MockedTeamRepo.mockReset();
  });
  it('Check if TeamMateRepository constructor was called once', () => {
    const teamMateRepository = new TeamMateRepository();
    expect(teamMateRepository.getByUserId('0')).toHaveProperty('teamId', 1);
  });
});
