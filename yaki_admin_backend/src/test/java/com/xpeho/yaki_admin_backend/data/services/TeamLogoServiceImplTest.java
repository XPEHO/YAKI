package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.TeamLogoModel;
import com.xpeho.yaki_admin_backend.data.sources.TeamLogoRepository;
import com.xpeho.yaki_admin_backend.domain.entities.TeamLogoEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.Arrays;
import java.util.Optional;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

import static org.junit.Assert.*;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@SpringBootTest
public class TeamLogoServiceImplTest {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @MockBean
    private TeamLogoRepository teamLogoRepository;

    @Autowired
    private TeamLogoServiceImpl teamLogoService;

    private TeamLogoModel teamLogoModel1;
    private TeamLogoModel teamLogoModel2;

    private TeamLogoEntity teamLogoEntity1;
    private TeamLogoEntity teamLogoEntity2;

    @BeforeEach
    void setup() {
        byte[] logoBlob1 = new byte[]{1, 2, 3, 4, 5};
        byte[] logoBlob2 = new byte[]{1, 2, 3, 4, 5};

        teamLogoModel1 = new TeamLogoModel(1, logoBlob1);
        teamLogoModel2 = new TeamLogoModel(2, logoBlob2);

        teamLogoEntity1 = new TeamLogoEntity(1, logoBlob1);
        teamLogoEntity2 = new TeamLogoEntity(2, logoBlob2);
    }

    @Test
    public void getTeamLogos() {
        // given
        byte[] logoBlob = new byte[]{1, 2, 3, 4, 5};
        TeamLogoEntity teamLogoEntity1 = new TeamLogoEntity(1, logoBlob);
        // ... set other properties of teamLogoEntity1
        given(teamLogoRepository.findOptionalByTeamLogoTeamId(1)).willReturn(Optional.of(teamLogoModel1));
        // when
        TeamLogoEntity teamLogoEntity = teamLogoService.getTeamLogoByTeamId(1);
        // then
        // Arrays.equals() is used to compare array content and not their adress in memory
        assertTrue(Arrays.equals(teamLogoEntity.teamLogoBlob(), teamLogoEntity1.teamLogoBlob()));
    }

    @Test
    public void createTeamLogo() {
        // given
        byte[] logoBlob = new byte[]{1, 2, 3, 4, 5};
        TeamLogoEntity teamLogoEntityToSave = new TeamLogoEntity(1, logoBlob);
        TeamLogoModel teamLogoModelToSave = new TeamLogoModel(1, logoBlob);
        given(teamLogoRepository.save(teamLogoModelToSave)).willReturn(teamLogoModel1);
        // when
        TeamLogoEntity teamLogoEntity = teamLogoService.save(teamLogoEntityToSave);
        // then
        assertThat(teamLogoEntity.teamId(), is(equalTo(teamLogoEntityToSave.teamId())));
        assertTrue(Arrays.equals(teamLogoEntity.teamLogoBlob(), teamLogoEntityToSave.teamLogoBlob()));
    }

    @Test
    public void deleteByTeamId() {
        // given
        byte[] logoBlob = new byte[]{1, 2, 3, 4, 5};
        TeamLogoEntity teamLogoEntityToDelete = new TeamLogoEntity(1, logoBlob);
        TeamLogoModel teamLogoModelToDelete = new TeamLogoModel(1, logoBlob);
        given(teamLogoRepository.findOptionalByTeamLogoTeamId(1)).willReturn(Optional.of(teamLogoModel1));
        // when
        teamLogoService.deleteByTeamId(1);
        // then
        Optional<TeamLogoModel> teamLogoEntity = teamLogoRepository.findOptionalByTeamLogoTeamId(1);
        assertThat(teamLogoEntity.isPresent(), is(true));
    }

}
