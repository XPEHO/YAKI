package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.CustomerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.willDoNothing;
import static org.mockito.Mockito.when;


@SpringBootTest
class CustomerServiceImplTest {
    private final ObjectMapper objectMapper = new ObjectMapper();
    private CustomerModel customer1;
    private CustomerEntity customerE1;
    private List<UserModel> usersCustomer;
    private OwnerModel owner1;
    @Autowired
    private CustomerServiceImpl customerService;

    @MockBean
    private CustomerJpaRepository customerJpaRepository;

    @BeforeEach
    void setup() {
        owner1 = new OwnerModel(1, 1);
        List<UserModel> usersCustomer = new ArrayList<>(3);
        customerE1 = new CustomerEntity(1, "A la ferme", 1, 2);
        customer1 = new CustomerModel(1, owner1, "A la ferme", 1, usersCustomer, 2);
    }

    @Test
    void getCustomerById() {
        // given


        // when
        when(customerJpaRepository.findById(1)).thenReturn(Optional.of(customer1));
        CustomerEntity customerDto = customerService.getCustomer(1);

        // then
        assertEquals(1, (int) customerDto.id());
        assertEquals("A la ferme", customerDto.customerName());
        assertEquals(1, customerDto.ownerId());
        assertEquals(2, customerDto.locationId());
    }

    @Test
    void getCustomerByIdTest() throws Exception {
        //given
        given(customerJpaRepository.findById(1)).willReturn(Optional.of(customer1));

        //when
        CustomerEntity customerDto = customerService.getCustomer(1);
        //then
        String returnedResponse = objectMapper.writeValueAsString(customerDto);
        String expectedResponse = objectMapper.writeValueAsString(customerE1);
        assertEquals(returnedResponse,
                expectedResponse);
    }

    @Test
    void createOwnerTest() throws Exception {
        //given
        given(customerJpaRepository.save(customer1)).willReturn(customer1);

        // when
        CustomerEntity savedOwner = customerService.createCustomer(customerE1);

        // then - verify the output
        assertNotEquals(savedOwner, (null));
    }

    @Test
    void deleteByIdTest() throws Exception {
        //given
        int deletedId = 1;
        CustomerModel deletedModel = new CustomerModel(deletedId, owner1, "A la cantine", 1, usersCustomer, 1);
        willDoNothing().given(customerJpaRepository).deleteById(deletedId);
        given(customerJpaRepository.findById(deletedId)).willReturn(Optional.of(deletedModel));

        //when
        CustomerEntity customerDeleted = customerService.deleteById(deletedId);

        //then
        assertEquals(customerDeleted,
                new CustomerEntity(deletedModel.getId(),
                        deletedModel.getName(), deletedModel.getOwnerId(), deletedModel.getLocationId()));
    }
}
