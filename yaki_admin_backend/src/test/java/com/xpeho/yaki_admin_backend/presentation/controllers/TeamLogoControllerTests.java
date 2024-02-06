package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.TeamLogoModel;
import com.xpeho.yaki_admin_backend.domain.entities.TeamLogoEntity;
import com.xpeho.yaki_admin_backend.domain.services.TeamLogoService;
import com.xpeho.yaki_admin_backend.error_handling.CustomExceptionHandler;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.Assert.assertArrayEquals;

import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
public class TeamLogoControllerTests {
    private MockMvc mvc;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Mock
    private TeamLogoService teamLogoService;

    @InjectMocks
    private TeamLogoController teamLogoController;

    @BeforeEach
    public void setup() {
        mvc = MockMvcBuilders.standaloneSetup(teamLogoController)
                .setControllerAdvice(new CustomExceptionHandler())
                .build();
    }

    private byte[] logoBlob = new byte[]{1, 2, 3, 4, 5};
    TeamLogoModel teamLogoModel = new TeamLogoModel(1, logoBlob);
    TeamLogoEntity teamLogoEntity = new TeamLogoEntity(1, logoBlob);


    @Test
    public void shouldReturnTeamLogoByTeamId() throws Exception {

        given(teamLogoService.getTeamLogoByTeamId(1)).willReturn(teamLogoEntity);

        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/teams/1/logo")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn()
                .getResponse();

        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(teamLogoEntity);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    @Test
    public void shouldCreateOrUpdateTeamLogoByTeamId() throws Exception {
        int teamId = 1;
        byte[] content = "image-content".getBytes();
        MultipartFile multipartFile = new MockMultipartFile("file", "image.jpeg", "text/plain", content);

        TeamLogoEntity expectedEntity = new TeamLogoEntity(teamId, content);
        given(teamLogoService.createOrUpdateByTeamId(teamId, content)).willReturn(expectedEntity);

        TeamLogoEntity resultEntity = teamLogoController.createOrUpdateByTeamId(teamId, multipartFile);

        assertArrayEquals(expectedEntity.teamLogoBlob(), resultEntity.teamLogoBlob());
        verify(teamLogoService, times(1)).createOrUpdateByTeamId(teamId, content);
    }

    @Test
    public void shouldDeleteTeamLogoByTeamId() throws Exception {

        Optional<TeamLogoEntity> teamLogoEntityOptional = Optional.of(teamLogoEntity);
        given(teamLogoService.deleteByTeamId(1)).willReturn(teamLogoEntityOptional);

        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.delete("/teams/1/logo")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn()
                .getResponse();

        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(teamLogoEntity);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }
}

