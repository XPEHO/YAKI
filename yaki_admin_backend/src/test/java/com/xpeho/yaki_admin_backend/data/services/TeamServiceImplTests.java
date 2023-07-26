package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.models.TeamModel;
import com.xpeho.yaki_admin_backend.data.sources.TeamJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
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
    private TeamModel team1;
    private TeamModel team2;
    private TeamEntity teamE1;
    private TeamEntity teamE2;

    private List<CaptainModel> captains = new ArrayList<>();

    @InjectMocks
    private TeamServiceImpl teamService;

    @Mock
    private TeamJpaRepository teamJpaRepository;
    @Mock
    private CaptainServiceImpl captainService;
    @Mock
    private CaptainsTeamsServiceImpl captainsTeamsService;

    @BeforeEach
    void setup() {
        captains.add( new CaptainModel(1,1, 1));
        team1 = new TeamModel(1,captains, "Team Yaki",1);
        team2 = new TeamModel(2, captains, "Team Yakoi",1);
        teamE1 = new TeamEntity(team1.getId(),Arrays.asList(1), "Team Yaki",1);
        teamE2 = new TeamEntity(team2.getId(),Arrays.asList(1), "Team Yakoi",1);
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
        given(captainService.findAllById(Arrays.asList(1))).willReturn(captains);
        given(teamJpaRepository.save(team1)).willReturn(team1);


        // when
        TeamEntity savedTeam = teamService.createTeam(teamE1);

        // then - verify the output
        assertNotEquals(savedTeam, (null));

    }

    @Test
    void saveTeamTest() throws Exception {

        //given
        int idUsed = 3;
        TeamModel replacedModel = new TeamModel(idUsed, this.captains, "Team Céou",1);
        TeamModel expectedModel = new TeamModel(
                idUsed, team2.getCaptains(), team2.getTeamName(),1);
        given(captainService.findAllById(Arrays.asList(1))).willReturn(captains);
        given(teamJpaRepository.save(expectedModel)).willReturn(expectedModel);
        given(teamJpaRepository.findById(idUsed)).willReturn(Optional.of(replacedModel));

        //when
        TeamEntity teamDto = teamService.saveOrUpdate(teamE2, idUsed);

        //then
        String returnedResponse = objectMapper.writeValueAsString(teamDto);
        TeamEntity teamE3 = new TeamEntity(
                idUsed, Arrays.asList(1), expectedModel.getTeamName(),1);
        String expectedResponse = objectMapper.writeValueAsString(teamE3);
        assertEquals(returnedResponse,
                expectedResponse);
    }

    @Test
    void deleteByIdTest() throws Exception {

        //given
        int deletedId = 1;
        TeamModel deletedModel = new TeamModel(deletedId, this.captains, "team Cékoi",1);
        willDoNothing().given(teamJpaRepository).deleteById(deletedId);
        given(teamJpaRepository.findById(deletedId)).willReturn(Optional.of(deletedModel));

        //when
        TeamEntity teamMateDeleted = teamService.deleteById(deletedId);

        //then
        assertEquals(teamMateDeleted,
                new TeamEntity(deletedModel.getId(),
                        Arrays.asList(1), deletedModel.getTeamName(),1));
    }

    @Test
    void findAllByCaptainTest() throws Exception {
        //given
        List<TeamModel> teamList = Arrays.asList(
                team2, team1,
                new TeamModel(3, captains, "Team 1",1)
        );
        List<TeamEntity> teamEList = Arrays.asList(
                teamE2, teamE1,
                new TeamEntity(3, Arrays.asList(1), "Team 1",1)
        );

        given(captainsTeamsService.findAllTeamsByCaptain(1)).willReturn(teamList);

        //when
        List<TeamEntity> teamEntities = teamService.findAllByCaptain(1);

        //then
        assertEquals(teamEntities, teamEList);
    }
}
