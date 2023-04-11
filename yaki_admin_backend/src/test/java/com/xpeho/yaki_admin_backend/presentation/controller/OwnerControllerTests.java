package com.xpeho.yaki_admin_backend.presentation.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import com.xpeho.yaki_admin_backend.domain.services.OwnerService;
import com.xpeho.yaki_admin_backend.presentation.controllers.OwnerController;
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
public class OwnerControllerTests {


    private final ObjectMapper objectMapper = new ObjectMapper();
    OwnerEntity owner1 = new OwnerEntity(1, 1);
    OwnerEntity owner2 = new OwnerEntity(2, 5);
    List<OwnerEntity> owners = Arrays.asList(owner1, owner2);
    private JacksonTester<OwnerEntity> jacksonEntities;
    private MockMvc mvc;
    @Mock
    private OwnerService ownerService;
    @InjectMocks
    private OwnerController ownerController;

    @BeforeEach
    public void setup() {

        // MockMvc standalone approach
        mvc = MockMvcBuilders.standaloneSetup(ownerController)
                .build();
    }

    @Test
    public void mustGetOwners() throws Exception {
        //given
        given(ownerService.findAll()).willReturn(owners);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/owners")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(owners);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));

    }

    @Test
    public void mustGetAOwners() throws Exception {

        //given
        given(ownerService.findById(2)).willReturn(owner2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/owners/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(owner2);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));

        //test with wrong id
        //given
        /*when(ownerService.findById(250)).thenReturn(null);


        assertThatExceptionOfType(EntityNotFoundException.class).isThrownBy(() -> {
            ownerService.findById(250);
        });*/

    }

    @Test
    public void mustCreateANewOwner() throws Exception {

        //given
        given(ownerService.createOwner(owner2)).willReturn(owner2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.post("/owners")
                                .contentType(MediaType.APPLICATION_JSON).content(objectMapper.writeValueAsString(owner2)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(owner1);
        JsonNode returnedResponse = objectMapper.readTree(response.getContentAsString());
        assertThat(returnedResponse.get("ownerUserId").asText(), is(equalTo(5)));

    }

    /*@Test
    public void mustDeleteAOwner() throws Exception {

        //given
        given(ownerService.deleteById(2);).willReturn(owner2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.delete("/owners/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(owner2);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));

    }*/


}
