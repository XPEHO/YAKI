package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.entities.LocationEntity;
import com.xpeho.yaki_admin_backend.domain.services.LocationService;
import com.xpeho.yaki_admin_backend.error_handling.CustomExceptionHandler;
import org.junit.jupiter.api.BeforeEach;
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
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.mockito.BDDMockito.given;

@ExtendWith(MockitoExtension.class)
public class LocationControllerTests {
    private MockMvc mvc;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final LocationEntity location1 = new LocationEntity(1, "La reine du bricolage", "2 rue des marteaux");
    private final LocationEntity location2 = new LocationEntity(2, "A la ferme", "24 ter rue du poulailler");

    private final List<LocationEntity> locations = Arrays.asList(location1, location2);

    @Mock
    private LocationService locationService;

    @InjectMocks
    private LocationController locationController;

    @BeforeEach
    public void setup() {
        mvc = MockMvcBuilders.standaloneSetup(locationController)
                .setControllerAdvice(new CustomExceptionHandler())
                .build();
    }

    @Test
    public void shouldReturnActiveLocations() throws Exception {

        //given
        given(locationService.getLocations()).willReturn(locations);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/locations")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn()
                .getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(locations);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    @Test
    public void shouldReturnLocationById() throws Exception {

        //given
        given(locationService.getLocationById(1)).willReturn(location1);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/locations/1")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn()
                .getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(location1);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    @Test
    public void shouldCreateLocation() throws Exception {
        //given
        given(locationService.createLocation(location1)).willReturn(location1);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.post("/locations")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(location1)))
                .andReturn()
                .getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(location1);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    @Test
    public void shouldUpdateLocation() throws Exception {
        //given
        given(locationService.saveOrUpdate(1, location1)).willReturn(location1);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.put("/locations/1")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(location1)))
                .andReturn()
                .getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(location1);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

    @Test
    public void shouldDisableLocation() throws Exception {
        //given
        given(locationService.disable(1)).willReturn(location1);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.put("/locations/disable/1")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(location1)))
                .andReturn()
                .getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(location1);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }

}
