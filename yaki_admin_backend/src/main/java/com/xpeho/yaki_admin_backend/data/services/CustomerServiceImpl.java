package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.CustomerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerServiceImpl implements CustomerService {

    final CustomerJpaRepository customerJpaRepository;


    public CustomerServiceImpl(CustomerJpaRepository customerJpaRepository) {
        this.customerJpaRepository = customerJpaRepository;
    }

    public void deleteById(Integer integer) {
        customerJpaRepository.deleteById(integer);
    }

    public void delete(CustomerModel entity) {
        customerJpaRepository.delete(entity);
    }

    @Override
    public List<CustomerEntity> getCustomers() {
        return customerJpaRepository
                .findAll()
                .stream()
                .map(customerModel -> new CustomerEntity(customerModel.getName(), customerModel.getOwnerId(), customerModel.getLocationId()))
                .toList();
    }

    @Override
    public CustomerEntity createCustomer(CustomerEntity customerEntity) {
        final CustomerModel customerModel = new CustomerModel(customerEntity.customer_name(), customerEntity.owner_id(), customerEntity.location_id());
        final CustomerModel savedModel = customerJpaRepository.save(customerModel);
        return customerEntity;
    }

    @Override
    public void addCustomerRight(List<UserModel> users, int customerId) {
        CustomerModel model = customerJpaRepository.getReferenceById(customerId);
        model.addUsers(users);
        customerJpaRepository.save(model);

    }

    @Override
    public CustomerEntity getCustomer(int id) {
        Optional<CustomerModel> captainModelOpt = customerJpaRepository.findById(id);
        if (!captainModelOpt.isPresent()) {
            throw new EntityNotFoundException("L'entité avec l'id " + id + " n'a pas été trouvée.");
        }
        CustomerModel captainModel = captainModelOpt.get();
        return new CustomerEntity(captainModel.getName(), captainModel.getOwnerId(), captainModel.getLocationId());
    }
}
