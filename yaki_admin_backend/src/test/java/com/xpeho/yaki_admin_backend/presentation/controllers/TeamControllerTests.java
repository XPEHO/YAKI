package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity;
import com.xpeho.yaki_admin_backend.domain.services.TeamService;
import com.xpeho.yaki_admin_backend.error_handling.CustomExceptionHandler;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.Arrays;
import java.util.List;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.mockito.BDDMockito.given;

@ExtendWith(MockitoExtension.class)
class TeamControllerTests {
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final TeamEntity TeamFeliz = new TeamEntity(1, List.of(1), "TeamFeliz", 1,
            "description team Feliz");
    private final TeamEntity TeamHappy = new TeamEntity(2, List.of(1), "TeamHappy", 1,
            "description team Happy");
    private final List<TeamEntity> teams = Arrays.asList(TeamFeliz, TeamHappy);
    private MockMvc mvc;

    @Mock
    private TeamService teamService;

    @InjectMocks
    private TeamController teamController;

    //creating a mock of the controller before each test
    @BeforeEach
    public void setup() {

        mvc = MockMvcBuilders.standaloneSetup(teamController)
                .setControllerAdvice(new CustomExceptionHandler())
                .build();
    }


    //testing the teamController.getTeam(id) method
    @Test
    void mustGetATeam() throws Exception {
        //given
        given(teamService.getTeam(2)).willReturn(TeamHappy);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/teams/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(TeamHappy);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    /* testing if the teamController.getTeam(id) return an EntityNotFound exception
    in case we have a nonexistent id. */
    @Test
    void mustGetANotFoundStatus() throws Exception {

        //given
        given(teamService.getTeam(250)).willThrow(EntityNotFoundException.class);

        //when
        MockHttpServletResponse result = mvc.perform(MockMvcRequestBuilders.get("/teams/250")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(result.getStatus(), is(equalTo(HttpStatus.NOT_FOUND.value())));
    }

    //testing the teamController.createTeam() method
    @Test
    void mustCreateANewTeam() throws Exception {

        //given
        given(teamService.createTeam(TeamHappy)).willReturn(TeamHappy);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.post("/teams")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(TeamHappy)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        JsonNode returnedResponse = objectMapper.readTree(response.getContentAsString());
        assertThat(returnedResponse.get("teamName").asText(), is(equalTo("TeamHappy")));
    }

    //testing the teamController.deleteTeam() method
    @Test
    void mustDeleteATeam() throws Exception {

        //given
        given(teamService.deleteById(2)).willReturn(TeamHappy);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.delete("/teams/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(TeamHappy);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    //testing the teamController.update() method
    @Test
    void mustPutATeam() throws Exception {
        TeamEntity team3 = new TeamEntity(
                2, TeamFeliz.captainsId(), TeamFeliz.teamName(), TeamFeliz.customerId(), TeamFeliz.description());

        //given
        given(teamService.saveOrUpdate(TeamFeliz, 2)).willReturn(team3);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.put("/teams/2")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(TeamFeliz)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(team3);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }
}
