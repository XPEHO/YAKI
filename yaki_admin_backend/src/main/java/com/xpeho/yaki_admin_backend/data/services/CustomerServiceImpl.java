package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.CustomerJpaRepository;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerRightsEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerServiceImpl implements CustomerService {

    private final CustomerJpaRepository customerJpaRepository;

    private final UserJpaRepository userJpaRepository;

    public CustomerServiceImpl(CustomerJpaRepository customerJpaRepository, UserJpaRepository userJpaRepository) {
        this.customerJpaRepository = customerJpaRepository;
        this.userJpaRepository = userJpaRepository;
    }

    @Override
    public List<CustomerEntity> getCustomers() {
        return customerJpaRepository
                .findAll()
                .stream()
                .map(customerModel -> new CustomerEntity(customerModel.getId(),
                        customerModel.getName(), customerModel.getOwnerId(), customerModel.getLocationId()))
                .toList();
    }

    @Override
    public CustomerEntity createCustomer(CustomerEntity customerEntity) {
        final CustomerModel customerModel = new CustomerModel(customerEntity.customerName(),
                customerEntity.ownerId(), customerEntity.locationId());
        customerJpaRepository.save(customerModel);
        return customerEntity;
    }

    @Override
    public CustomerEntity addCustomerRight(CustomerRightsEntity customerRightsEntity) {
        CustomerModel model = customerJpaRepository.getReferenceById(customerRightsEntity.customerId());
        List<UserModel> users = userJpaRepository.findAllById(customerRightsEntity.usersId());
        model.addUsers(users);

        CustomerModel customerModel = customerJpaRepository.save(model);
        return new CustomerEntity(customerModel.getId(), customerModel.getName(), customerModel.getOwnerId(), customerModel.getLocationId());
    }

    @Override
    public CustomerEntity getCustomer(int id) {
        Optional<CustomerModel> customerModelOpt = customerJpaRepository.findById(id);
        if (customerModelOpt.isEmpty()) {
            throw new EntityNotFoundException("Entity Customer with id " + id + " has not been found");
        }
        CustomerModel customerModel = customerModelOpt.get();
        return new CustomerEntity(customerModel.getId(), customerModel.getName(),
                customerModel.getOwnerId(), customerModel.getLocationId());
    }

    @Override
    public CustomerEntity deleteById(int id) {
        Optional<CustomerModel> customerModelOpt = customerJpaRepository.findById(id);
        if (customerModelOpt.isEmpty()) {
            throw new EntityNotFoundException("Entity Customer with id " + id + " has not been found");
        } else {
            CustomerModel customerModel = customerModelOpt.get();
            customerJpaRepository.deleteById(id);
            return new CustomerEntity(customerModel.getId(), customerModel.getName()
                    , customerModel.getOwnerId(), customerModel.getLocationId());
        }
    }

    @Override
    public CustomerEntity saveOrUpdate(CustomerEntity entity, int id) {
        Optional<CustomerModel> customerModelOpt = customerJpaRepository.findById(id);
        if (customerModelOpt.isPresent()) {
            CustomerModel customerModel = customerModelOpt.get();
            customerModel.setName(entity.customerName());
            customerModel.setLocationId(entity.locationId());
            customerJpaRepository.save(customerModel);
        } else {
            throw new EntityNotFoundException("Entity customer with id " + id + " not found");
        }
        return new CustomerEntity(id, entity.customerName(),
                entity.ownerId(), entity.locationId());
    }

    @Override
    public List<CustomerEntity> getAllCustomersRightByUserId(int userId) {
        Optional<UserModel> userModelOpt = userJpaRepository.findById(userId);
        if(!userModelOpt.isPresent()){
            throw new EntityNotFoundException("Entity user with id " + userId + " not found");
        }
        else{
            UserModel userModel = userModelOpt.get();
            List<CustomerModel> customersModels = userModel.getCustomers();
            return customersModels
                    .stream()
                    .map(customerModel -> new CustomerEntity(customerModel.getId(),
                            customerModel.getName(),customerModel.getOwnerId(),
                            customerModel.getLocationId()))
                    .toList();
        }
    }


}

