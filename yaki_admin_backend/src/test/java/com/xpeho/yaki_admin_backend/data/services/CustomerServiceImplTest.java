package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.CustomerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;


@SpringBootTest
class CustomerServiceImplTest {
    @Autowired
    private CustomerServiceImpl customerService;
    @MockBean
    private CustomerJpaRepository customerJpaRepository;

    @Test
    void getCustomerById() {
        // given
        OwnerModel ownerModel = new OwnerModel(1, 1);
        List<UserModel> usersCustomer = new ArrayList<>(3);

        CustomerModel customerModel = new CustomerModel(1, ownerModel, "A la ferme", 1, usersCustomer, 2);

        // when
        when(customerJpaRepository.findById(1)).thenReturn(Optional.of(customerModel));
        CustomerEntity customerDto = customerService.getCustomer(1);

        // then
        assertEquals(1, (int) customerDto.id());
        assertEquals("A la ferme", customerDto.customerName());
        assertEquals(1, customerDto.ownerId());
        assertEquals(2, customerDto.locationId());
    }
}
