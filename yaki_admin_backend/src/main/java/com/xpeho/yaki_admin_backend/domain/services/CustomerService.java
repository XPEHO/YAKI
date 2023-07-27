package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerRightsEntity;

import java.util.List;

public interface CustomerService {

    List<CustomerEntity> getCustomers();

    CustomerEntity createCustomer(CustomerEntity customerEntity);

    CustomerEntity addCustomerRight(CustomerRightsEntity customerRightsEntity);

    CustomerEntity getCustomer(int id);

    CustomerEntity deleteById(int id);

    CustomerEntity disabled(int id);

    CustomerEntity saveOrUpdate(CustomerEntity entity, int id);

    List<CustomerEntity> getAllCustomersRightByUserId(int id);
}
