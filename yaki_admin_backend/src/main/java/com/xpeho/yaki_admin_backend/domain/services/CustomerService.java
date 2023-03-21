package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;

import java.util.List;

public interface CustomerService {

    List<CustomerEntity> getCustomers();

    CustomerEntity createCustomer(CustomerEntity customerEntity);
}
