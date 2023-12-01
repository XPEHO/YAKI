package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.models.EntityLogModel;
import com.xpeho.yaki_admin_backend.data.models.TeamModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.TeamJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntityWithDetails;
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity;
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntityWithCaptainsDetails;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.willDoNothing;

@ExtendWith(MockitoExtension.class)
class TeamServiceImplTests {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final List<CaptainModel> captains = new ArrayList<>();
    private TeamModel team1;
    private TeamModel team2;
    private TeamEntity teamE1;
    private TeamEntity teamE2;
    private EntityLogModel entityLogModel;

    @InjectMocks
    private TeamServiceImpl teamService;

    @Mock
    private TeamJpaRepository teamJpaRepository;
    @Mock
    private CaptainServiceImpl captainService;
    @Mock
    private CaptainsTeamsServiceImpl captainsTeamsService;

    @Mock
    private EntityLogServiceImpl entityLogService;

    @BeforeEach
    void setup() {
        entityLogModel = new EntityLogModel();
        captains.add(new CaptainModel(1, 1, 1, 2));
        team1 = new TeamModel(1, captains, "Team Yaki", 1, entityLogModel.getId(), "description team Yaki");
        team2 = new TeamModel(2, captains, "Team Yakoi", 1, entityLogModel.getId(), "description team Yakoi");
        teamE1 = new TeamEntity(team1.getId(), List.of(1), "Team Yaki", 1, "description team Yaki");
        teamE2 = new TeamEntity(team2.getId(), List.of(1), "Team Yakoi", 1, "description team Yakoi");

    }

    @Test
    void getTeamByIdTest() throws Exception {

        //given
        given(teamJpaRepository.findById(1)).willReturn(Optional.of(team1));

        //when
        TeamEntity teamDto = teamService.getTeam(1);

        //then
        String returnedResponse = objectMapper.writeValueAsString(teamDto);
        String expectedResponse = objectMapper.writeValueAsString(teamE1);
        assertEquals(returnedResponse,
                expectedResponse);
    }

    @MockitoSettings(strictness = Strictness.WARN)
    @Test
    void createTeamTest() throws Exception {

        //given
        given(captainService.findAllById(List.of(1))).willReturn(captains);
        given(teamJpaRepository.save(team1)).willReturn(team1);
        given(entityLogService.createEntityLog()).willReturn(entityLogModel);

        // when
        TeamEntity savedTeam = teamService.createTeam(teamE1);

        // then - verify the output
        assertNotEquals(savedTeam, (null));

    }

    @Test
    void saveTeamTest() throws Exception {

        //given
        int idUsed = 3;
        TeamModel replacedModel = new TeamModel(idUsed, this.captains, "Team Céou", 1, entityLogModel.getId(),
                "Team Céou asks: where is it?");
        TeamModel expectedModel = new TeamModel(idUsed, team2.getCaptains(), team2.getTeamName(), 1, entityLogModel.getId(),
                "description team Yakoi");
        given(captainService.findAllById(List.of(1))).willReturn(captains);
        given(teamJpaRepository.save(expectedModel)).willReturn(expectedModel);
        given(teamJpaRepository.findById(idUsed)).willReturn(Optional.of(replacedModel));

        //when
        TeamEntity teamDto = teamService.saveOrUpdate(teamE2, idUsed);

        //then
        String returnedResponse = objectMapper.writeValueAsString(teamDto);
        TeamEntity teamE3 = new TeamEntity(
                idUsed, List.of(1), expectedModel.getTeamName(), 1, expectedModel.getTeamDescription());
        String expectedResponse = objectMapper.writeValueAsString(teamE3);
        assertEquals(returnedResponse,
                expectedResponse);
    }

    @Test
    void deleteByIdTest() throws Exception {

        //given
        int deletedId = 1;
        TeamModel deletedModel = new TeamModel(deletedId, this.captains, "team Cékoi", 1, entityLogModel.getId(),
                "Cékoi is a team that asks a lot of questions");
        willDoNothing().given(teamJpaRepository).deleteById(deletedId);
        given(teamJpaRepository.findById(deletedId)).willReturn(Optional.of(deletedModel));

        //when
        TeamEntity teamMateDeleted = teamService.deleteById(deletedId);

        //then
        assertEquals(teamMateDeleted,
                new TeamEntity(deletedModel.getId(),
                        List.of(1), deletedModel.getTeamName(), 1, deletedModel.getTeamDescription()));
    }

    @Test
    void findAllByCaptainTest() throws Exception {
        //given
        List<TeamModel> teamList = Arrays.asList(
                team2, team1,
                new TeamModel(3, captains, "Team Yakoi", 1, entityLogModel.getId(), "description team Yakoi")
        );
        List<TeamEntity> teamEList = Arrays.asList(
                teamE2, teamE1,
                new TeamEntity(3, List.of(1), "Team Yakoi", 1, "description team Yakoi")
        );

        given(captainsTeamsService.findAllTeamsByCaptain(1)).willReturn(teamList);

        //when
        List<TeamEntity> teamEntities = teamService.findAllByCaptain(1);

        //then
        assertEquals(teamEntities, teamEList);
    }

    @Test
    public void testFindAllTeamByCustomerId() {
        // Given
        int customerId = 1;

        // Create a mock UserModel
        UserModel user = new UserModel(1, "Hautmont", "Robert", "email", "login", "pw");
        UserModel user2 = new UserModel(2, "Basmont", "Rubert", "email", "login", "pw");

        // Create valid CaptainModel instances with associated UserModel
        List<CaptainModel> captains = new ArrayList<>();
        CaptainModel captain1 = new CaptainModel(1, 1, 1, 1);
        captain1.setUser(user);  // Associate the mock UserModel
        captains.add(captain1);

        CaptainModel captain2 = new CaptainModel(2, 2, 2, 2);
        captain2.setUser(user2);  // Associate the mock UserModel
        captains.add(captain2);

        List<TeamModel> teamModels = new ArrayList<>();
        teamModels.add(new TeamModel(1, captains, "Team Yaki", 1, 1, "description team Yaki"));
        teamModels.add(new TeamModel(2, captains, "Team Yakoi", 1, 2, "description team Yakoi"));
        Mockito.when(teamJpaRepository.findAllByCustomerIdAndActifIsTrue(customerId)).thenReturn(teamModels);

        // Create expectedTeamEntities with CaptainEntityWithDetails instances
        List<TeamEntityWithCaptainsDetails> expectedTeamEntities = new ArrayList<>();
        List<CaptainEntityWithDetails> expectedCaptains = new ArrayList<>();
        expectedCaptains.add(new CaptainEntityWithDetails(1, "Hautmont", "Robert"));
        expectedCaptains.add(new CaptainEntityWithDetails(2, "Basmont", "Rubert"));
        expectedTeamEntities.add(new TeamEntityWithCaptainsDetails(1, "Team Yaki", 1, expectedCaptains));
        expectedTeamEntities.add(new TeamEntityWithCaptainsDetails(2, "Team Yakoi", 1, expectedCaptains));

        List<TeamEntityWithCaptainsDetails> actualTeamEntities = teamService.findAllTeamByCustomerId(customerId);
        //then
        assertEquals(expectedTeamEntities, actualTeamEntities);
    }

}

