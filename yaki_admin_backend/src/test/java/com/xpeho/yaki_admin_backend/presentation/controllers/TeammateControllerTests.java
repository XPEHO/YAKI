package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.TeammateService;
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
class TeammateControllerTests {
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final TeammateEntity teammate1 = new TeammateEntity(1, 1, 5);
    private final TeammateEntity teammate2 = new TeammateEntity(2, 1, 8);
    private final TeammateEntity teammate3 = new TeammateEntity(3, 2, 6);
    private final List<TeammateEntity> teammates = Arrays.asList(teammate1, teammate2, teammate3);
    private final UserEntityWithID teammate4 = new UserEntityWithID(4, 1,1,"Dupond", "Jack", "dupond.jack@mail.com");
    private final UserEntityWithID teammate5 = new UserEntityWithID(4, 2,2,"Dugrond", "Jean", "dugrond.jean@mail.com");
    private final List<UserEntityWithID> teammatesFromTeamOne = Arrays.asList(teammate4, teammate5);
    private MockMvc mvc;
    @Mock
    private TeammateService teammateService;
    @InjectMocks
    private TeammateController teammateController;

    //creating a mock of the controller before each test
    @BeforeEach
    public void setup() {

        mvc = MockMvcBuilders.standaloneSetup(teammateController)
                .setControllerAdvice(new CustomExceptionHandler())
                .build();
    }

    //testing the teammateController.getTeammate(id) method
    @Test
    void mustGetATeammate() throws Exception {

        //given
        given(teammateService.getTeammate(2)).willReturn(teammate2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/teammates/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(teammate2);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    /* testing if the teammateController.getTeammate(id) return an EntityNotFound exception
    in case we have a nonexistent id. */
    @Test
    void mustGetANotFoundStatus() throws Exception {

        //given
        given(teammateService.getTeammate(250)).willThrow(EntityNotFoundException.class);

        //when
        MockHttpServletResponse result = mvc.perform(MockMvcRequestBuilders.get("/teammates/250")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(result.getStatus(), is(equalTo(HttpStatus.NOT_FOUND.value())));
    }

    //testing the teammateController.createTeammate() method
    @Test
    void mustCreateANewTeammate() throws Exception {

        //given
        given(teammateService.createTeammate(teammate2)).willReturn(teammate2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.post("/teammates")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(teammate2)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        JsonNode returnedResponse = objectMapper.readTree(response.getContentAsString());
        assertThat(returnedResponse.get("teamId").asText(), is(equalTo("1")));
        assertThat(returnedResponse.get("userId").asText(), is(equalTo("8")));

    }

    //testing the teammateController.deleteTeammate() method
    @Test
    void mustDeleteATeammate() throws Exception {

        //given
        given(teammateService.deleteById(2)).willReturn(teammate2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.delete("/teammates/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(teammate2);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    //testing the teammateController.update() method
    @Test
    void mustPutATeammate() throws Exception {
        TeammateEntity teammate3 = new TeammateEntity(
                2, teammate1.teamId(), teammate1.userId());

        //given
        given(teammateService.saveOrUpdate(teammate1, 2)).willReturn(teammate3);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.put("/teammates/2")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(teammate1)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(teammate3);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    @Test
    void getAllWithinTeam() throws Exception {

        //given
        given(teammateService.findAllByTeam(1)).willReturn(teammatesFromTeamOne);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/teammates/team/1")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(teammatesFromTeamOne);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }
}
