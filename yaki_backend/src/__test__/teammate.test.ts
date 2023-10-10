import { StatusDeclaration } from '../features/declaration/status.enum';
import { TeammateRepository } from '../features/teammate/teammate.repository';
import { TeammateService } from '../features/teammate/teammate.service';
import { TeammateWithDeclaration } from '../features/teammate/teammateWithDeclaration.dtoOut';

describe('TeammateService', () => {
  let teammateService: TeammateService;
  let teammateRepository: jest.Mocked<TeammateRepository>;

  beforeEach(() => {
    teammateRepository = {
      getByTeamIdWithLastDeclaration: jest.fn(),
    } as jest.Mocked<TeammateRepository>;

    teammateService = new TeammateService(teammateRepository);
  });

  describe('getByTeamIdWithLastDeclaration', () => {
    it('should return an array of TeammateWithDeclaration', async () => {
      const mockTeammates = [
        {
          user_id: 1,
          user_last_name: 'Doe',
          user_first_name: 'John',
          declaration_date: new Date('2023/8/20'),
          declaration_status: StatusDeclaration.REMOTE,
          team_id: 3,
          team_name: 'Team A',
          declaration_date_start: new Date('2023/8/20'),
          declaration_date_end: new Date('2023/8/20'),
          declaration_id: 1,
          declaration_user_id: 1,
        },
      ];

      teammateRepository.getByTeamIdWithLastDeclaration.mockResolvedValueOnce(
        mockTeammates
      );

      const result = await teammateService.getByTeamIdWithLastDeclaration(1);

      expect(result).toEqual([
        new TeammateWithDeclaration(
          1,
          'Doe',
          'John',
          new Date('2023/8/20'),
          StatusDeclaration.REMOTE,
          3,
          'Team A',
          new Date('2023/8/20'),
          new Date('2023/8/20'),
          1,
          1
        ),
      ]);
    });
  });
});
