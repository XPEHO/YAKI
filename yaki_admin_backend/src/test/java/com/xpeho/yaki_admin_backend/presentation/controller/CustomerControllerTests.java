package com.xpeho.yaki_admin_backend.presentation.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import com.xpeho.yaki_admin_backend.presentation.controllers.CustomerController;
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
public class CustomerControllerTests {

    private final ObjectMapper objectMapper = new ObjectMapper();
    CustomerEntity customer1 = new CustomerEntity(1, "name", 1, 1);
    CustomerEntity customer2 = new CustomerEntity(2, "Auchan", 1, 2);
    List<CustomerEntity> customers = Arrays.asList(customer1, customer2);
    private JacksonTester<CustomerEntity> jacksonEntities;
    private MockMvc mvc;
    @Mock
    private CustomerService customerService;
    @InjectMocks
    private CustomerController customerController;

    @BeforeEach
    public void setup() {

        // MockMvc standalone approach
        mvc = MockMvcBuilders.standaloneSetup(customerController)
                .build();
    }

    @Test
    public void mustGetCustomers() throws Exception {
        //given
        given(customerService.getCustomers()).willReturn(customers);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/customers")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(customers);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));

    }

    @Test
    public void mustGetACustomers() throws Exception {

        //given
        given(customerService.getCustomer(2)).willReturn(customer2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.get("/customers/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(customer2);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));

        //test with wrong id
        //given
        given(customerService.getCustomer(250)).willThrow(EntityNotFoundException.class);

        //when
        MockHttpServletResponse response2 = mvc.perform(
                        MockMvcRequestBuilders.get("/customers/250")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(response2.getStatus(), is(equalTo(HttpStatus.NOT_FOUND.value())));
        String expectedResponse2 = objectMapper.writeValueAsString(customer2);
        assertThat(response2.getContentAsString(), is(equalTo(
                expectedResponse2)));

    }

    @Test
    public void mustCreateANewCustomer() throws Exception {

        //given
        given(customerService.createCustomer(customer2)).willReturn(customer2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.post("/customers")
                                .contentType(MediaType.APPLICATION_JSON).content(objectMapper.writeValueAsString(customer2)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(customer1);
        JsonNode returnedResponse = objectMapper.readTree(response.getContentAsString());
        assertThat(returnedResponse.get("customerName").asText(), is(equalTo("Auchan")));

    }

    @Test
    public void mustDeleteACustomer() throws Exception {

        //given
        given(customerService.deleteById(2)).willReturn(customer2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.delete("/customers/2")
                                .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(customer2);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));

    }

    @Test
    public void mustPutACustomer() throws Exception {
        CustomerEntity customer3 = new CustomerEntity(2, customer1.customerName(), customer1.ownerId(), customer1.locationId());
        //given
        given(customerService.saveOrUpdate(customer1, 2)).willReturn(customer3);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.put("/customers/2")
                                .contentType(MediaType.APPLICATION_JSON).content(objectMapper.writeValueAsString(customer1)))
                .andReturn().getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(customer3);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));

    }
}

