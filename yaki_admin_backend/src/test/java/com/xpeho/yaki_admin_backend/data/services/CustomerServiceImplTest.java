package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.CustomerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerRightsEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.*;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.mockito.ArgumentMatchers.any;
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
        this.usersCustomer = new ArrayList<>(3);
        customerE1 = new CustomerEntity(1, "A la ferme", 1, 2);
        customer1 = new CustomerModel(1, owner1, "A la ferme", 1, usersCustomer, 2,1);
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
        CustomerModel deletedModel = new CustomerModel(deletedId, owner1, "A la cantine", 1, usersCustomer, 1,1);
        willDoNothing().given(customerJpaRepository).deleteById(deletedId);
        given(customerJpaRepository.findById(deletedId)).willReturn(Optional.of(deletedModel));

        //when
        CustomerEntity customerDeleted = customerService.deleteById(deletedId);

        //then
        assertEquals(customerDeleted,
                new CustomerEntity(deletedModel.getId(),
                        deletedModel.getName(), deletedModel.getOwnerId(), deletedModel.getLocationId()));
    }

    @Test
    void getCustomersTest() {
        //given
        List<CustomerModel> customerModels = Arrays.asList(
                new CustomerModel("Géo trouve tout", 1, 1,1),
                new CustomerModel("Géo trouve rien", 1, 4,1),
                new CustomerModel("Géo perd tout", 2, 2,1)
        );

        //when
        given(customerJpaRepository.findAll()).willReturn(customerModels);
        List<CustomerEntity> customerEntities = customerService.getCustomers();

        //then
        assertEquals(3, customerEntities.size());
        assertEquals("Géo trouve tout", customerEntities.get(0).customerName());
        assertEquals(2, (int) customerEntities.get(2).ownerId());
        assertEquals(4, (int) customerEntities.get(1).locationId());
    }

    @Test
    void addCustomerRightTest() {
        //given
        CustomerRightsEntity customerRightsEntity = new CustomerRightsEntity(1, Collections.singletonList(1));
        CustomerModel customerModel = new CustomerModel(1, owner1, "A la ferme", 1, usersCustomer, 2,1);
        given(customerJpaRepository.getReferenceById(customerRightsEntity.customerId())).willReturn(customerModel);
        given(customerJpaRepository.save(customerModel)).willReturn(customerModel);
        //when
        CustomerEntity customerEntity = customerService.addCustomerRight(customerRightsEntity);
        //then
        assertEquals(customerEntity,
                new CustomerEntity(1,
                        customerModel.getName(), customerModel.getOwnerId(), customerModel.getLocationId()));

    }

    @Test
    void saveOrUpdate() {
        //given
        CustomerEntity customerE2 = new CustomerEntity(34, "A la berge", 23, 16);
        given(customerJpaRepository.findById(1)).willReturn(Optional.of(customer1));
        given(customerJpaRepository.save(any(CustomerModel.class))).willReturn(any(CustomerModel.class));
        //when
        CustomerEntity customerResult = customerService.saveOrUpdate(customerE2, 1);
        //then
        assertEquals(customerResult,
                new CustomerEntity(1,
                        customerE2.customerName(), customerE2.ownerId(), customerE2.locationId()));
    }

}
