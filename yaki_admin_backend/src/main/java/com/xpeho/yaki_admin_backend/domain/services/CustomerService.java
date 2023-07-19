package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;

import java.util.List;

public interface CustomerService {

    List<CustomerEntity> getCustomers();

    CustomerEntity createCustomer(CustomerEntity customerEntity);

    CustomerEntity addCustomerRight(int userId, int customerId);

    CustomerEntity getCustomer(int id);

    CustomerEntity deleteById(int id);

    CustomerEntity saveOrUpdate(CustomerEntity entity, int id);

    CustomerEntity findById(int customerId);

    CustomerEntity save(CustomerEntity customer);
}
