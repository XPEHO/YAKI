package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.sources.CustomerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    final CustomerJpaRepository customerJpaRepository;

    public CustomerServiceImpl(CustomerJpaRepository customerJpaRepository) {
        this.customerJpaRepository = customerJpaRepository;
    }

    @Override
    public List<CustomerEntity> getCustomers() {
        return customerJpaRepository
                .findAll()
                .stream()
                .map( customerModel -> new CustomerEntity(customerModel.getId(), customerModel.getName()) )
                .toList();
    }

    @Override
    public CustomerEntity createCustomer(CustomerEntity customerEntity) {
        final CustomerModel model = new CustomerModel(customerEntity.id(), customerEntity.name());
        final CustomerModel savedModel = customerJpaRepository.save(model);
        return new CustomerEntity(savedModel.getId(), savedModel.getName());
    }
}
