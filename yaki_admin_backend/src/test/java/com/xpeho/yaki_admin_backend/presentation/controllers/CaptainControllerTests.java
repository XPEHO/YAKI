package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.services.CaptainService;
import com.xpeho.yaki_admin_backend.errorHandling.CustomExceptionHandler;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.json.JacksonTester;
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
public class CaptainControllerTests {

    private final ObjectMapper objectMapper = new ObjectMapper();

    CaptainEntity captain1 = new CaptainEntity(1, 6, 2);

    CaptainEntity captain2 = new CaptainEntity(2, 4, 2);

    List<CaptainEntity> captains = Arrays.asList(captain1, captain2);

    private JacksonTester<CaptainEntity> jacksonEntities;

    private MockMvc mvc;

    @Mock
    private CaptainService captainService;

    @InjectMocks
    private CaptainController captainController;

    //creating a mock of the controller before each test

    @BeforeEach
    public void setup() {
        mvc = MockMvcBuilders.standaloneSetup(captainController)
                .setControllerAdvice(new CustomExceptionHandler())
                .build();
    }

    //testing the customerController.getCustomers() method
    @Test
    public void mustGetCustomers() throws Exception {
        //given
        given(captainService.getCaptains()).willReturn(captains);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/captains")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(captains);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    //testing the captainController.getCaptain(id) method
    @Test
    public void mustGetACaptain() throws Exception {

        //given
        given(captainService.getCaptainById(2)).willReturn(captain2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/captains/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(captain2);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    /* testing if the captainController.getCaptain(id) return an EntityNotFound exception
    in case we have a nonexistent id. */
    @Test
    public void mustGetANotFoundStatus() throws Exception {

        //given
        given(captainService.getCaptainById(300)).willThrow(EntityNotFoundException.class);

        //when
        MockHttpServletResponse result = mvc.perform(MockMvcRequestBuilders.get("/captains/300")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(result.getStatus(), is(equalTo(HttpStatus.NOT_FOUND.value())));
    }

    //testing the captainController.createCaptain() method
    @Test
    public void mustCreateANewCaptain() throws Exception {

        //given
        given(captainService.createCaptain(captain2)).willReturn(captain2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.post("/captains")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(captain2)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        JsonNode returnedResponse = objectMapper.readTree(response.getContentAsString());
        assertThat(returnedResponse.get("userId").asText(), is(equalTo("4")));
    }

    //testing the captainController.deleteCaptain() method
    @Test
    public void mustDeleteACaptain() throws Exception {
        //given
        given(captainService.deleteById(2)).willReturn(captain2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.delete("/captains/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(captain2);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    //testing the captainController.update() method
    @Test
    public void mustPutACaptain() throws Exception {
        CaptainEntity captain3 = new CaptainEntity(
                2, captain1.userId(), captain1.customerId());

        //given
        given(captainService.saveOrUpdate(captain1, 2)).willReturn(captain3);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.put("/captains/2")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(captain1)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(captain3);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }
}