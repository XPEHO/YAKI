package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
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

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.willDoNothing;

@ExtendWith(MockitoExtension.class)
public class TeamServiceImplTests {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private TeamModel team1;
    private TeamModel team2;
    private TeamEntity teamE1;
    private TeamEntity teamE2;

    @InjectMocks
    private TeamServiceImpl teamService;

    @Mock
    private TeamJpaRepository teamJpaRepository;

    @BeforeEach
    void setup() {
        team1 = new TeamModel(1, 1, "Team Yaki");
        team2 = new TeamModel(2, 1, "Team Yakoi");
        teamE1 = new TeamEntity(team1.getId(), 1, "Team Yaki");
        teamE2 = new TeamEntity(team2.getId(), 1, "Team Yakoi");
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
        TeamModel replacedModel = new TeamModel(idUsed, 235, "Team Céou");
        TeamModel expectedModel = new TeamModel(
                idUsed, team2.getCaptainId(), team2.getTeamName());
        given(teamJpaRepository.save(expectedModel)).willReturn(expectedModel);
        given(teamJpaRepository.findById(idUsed)).willReturn(Optional.of(replacedModel));

        //when
        TeamEntity teamDto = teamService.saveOrUpdate(teamE2, idUsed);

        //then
        String returnedResponse = objectMapper.writeValueAsString(teamDto);
        TeamEntity teamE3 = new TeamEntity(
                idUsed, expectedModel.getCaptainId(), expectedModel.getTeamName());
        String expectedResponse = objectMapper.writeValueAsString(teamE3);
        assertEquals(returnedResponse,
                expectedResponse);
    }

    @Test
    void deleteByIdTest() throws Exception {

        //given
        int deletedId = 1;
        TeamModel deletedModel = new TeamModel(deletedId, 25, "team Cékoi");
        willDoNothing().given(teamJpaRepository).deleteById(deletedId);
        //given(teamJpaRepository.existsById(deletedId)).willReturn(Boolean.TRUE);
        given(teamJpaRepository.findById(deletedId)).willReturn(Optional.of(deletedModel));

        //when
        TeamEntity teamMateDeleted = teamService.deleteById(deletedId);

        //then
        assertEquals(teamMateDeleted,
                new TeamEntity(deletedModel.getId(),
                        deletedModel.getCaptainId(), deletedModel.getTeamName()));
    }
}
