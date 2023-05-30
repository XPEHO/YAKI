package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import com.xpeho.yaki_admin_backend.errorHandling.CustomExceptionHandler;
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
class CustomerControllerTests {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final CustomerEntity customer1 = new CustomerEntity(1, "La reine du bricolage", 1, 1);
    private final CustomerEntity customer2 = new CustomerEntity(2, "A la ferme", 1, 2);
    private final List<CustomerEntity> customers = Arrays.asList(customer1, customer2);
    private MockMvc mvc;

    @Mock
    private CustomerService customerService;

    @InjectMocks
    private CustomerController customerController;

    //creating a mock of the controller before each test
    @BeforeEach
    public void setup() {

        mvc = MockMvcBuilders.standaloneSetup(customerController)
                .setControllerAdvice(new CustomExceptionHandler())
                .build();
    }

    //testing the customerController.getCustomers() method
    @Test
    void mustGetCustomers() throws Exception {

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

    //testing the customerController.getCustomer(id) method
    @Test
    void mustGetACustomer() throws Exception {

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
    }

    /* testing if the customerController.getCustomer(id) return an EntityNotFound exception
    in case we have a nonexistent id. */
    @Test
    void mustGetANotFoundStatus() throws Exception {

        //given
        given(customerService.getCustomer(250)).willThrow(EntityNotFoundException.class);

        //when
        MockHttpServletResponse result = mvc.perform(MockMvcRequestBuilders.get("/customers/250")
                        .accept(MediaType.APPLICATION_JSON))
                .andReturn().getResponse();

        //then
        assertThat(result.getStatus(), is(equalTo(HttpStatus.NOT_FOUND.value())));
    }

    //testing the customerController.createCustomer() method
    @Test
    void mustCreateANewCustomer() throws Exception {

        //given
        given(customerService.createCustomer(customer2)).willReturn(customer2);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.post("/customers")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(customer2)))
                .andReturn().getResponse();

        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        JsonNode returnedResponse = objectMapper.readTree(response.getContentAsString());
        assertThat(returnedResponse.get("customerName").asText(), is(equalTo("A la ferme")));
    }

    //testing the customerController.deleteCustomer() method
    @Test
    void mustDeleteACustomer() throws Exception {

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

    //testing the customerController.update() method
    @Test
    void mustPutACustomer() throws Exception {
        CustomerEntity customer3 = new CustomerEntity(
                2, customer1.customerName(), customer1.ownerId(), customer1.locationId());
        //given
        given(customerService.saveOrUpdate(customer1, 2)).willReturn(customer3);

        //when
        MockHttpServletResponse response = mvc.perform(
                        MockMvcRequestBuilders.put("/customers/2")
                                .contentType(MediaType.APPLICATION_JSON)
                                .content(objectMapper.writeValueAsString(customer1)))
                .andReturn().getResponse();
        //then
        assertThat(response.getStatus(), is(equalTo(HttpStatus.OK.value())));
        String expectedResponse = objectMapper.writeValueAsString(customer3);
        assertThat(response.getContentAsString(), is(equalTo(
                expectedResponse)));
    }
}
