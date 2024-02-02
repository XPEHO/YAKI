package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.models.EntityLogModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.CustomerJpaRepository;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerRightsEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CustomerServiceImpl implements CustomerService {

    private final CustomerJpaRepository customerJpaRepository;

    private final UserJpaRepository userJpaRepository;

    private final EntityLogServiceImpl entityLogService;

    public CustomerServiceImpl(CustomerJpaRepository customerJpaRepository, UserJpaRepository userJpaRepository, EntityLogServiceImpl entityLogService) {
        this.customerJpaRepository = customerJpaRepository;
        this.userJpaRepository = userJpaRepository;
        this.entityLogService = entityLogService;
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
        EntityLogModel entityLogModel = entityLogService.createEntityLog();
        final CustomerModel customerModelToSave = new CustomerModel(
                customerEntity.customerName(),
                customerEntity.ownerId(),
                customerEntity.locationId(),
                entityLogModel.getId());

        final CustomerModel responseModel = customerJpaRepository.save(customerModelToSave);
        System.out.println(responseModel);

        final CustomerEntity responseEntity = new CustomerEntity(
                responseModel.getId(),
                responseModel.getName(),
                responseModel.getOwnerId(),
                responseModel.getLocationId()
        );
        System.out.println(responseEntity);
        return responseEntity;
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

    //disable the teammate but keep in log
    @Override
    public CustomerEntity disabled(int customerId) {
        Optional<CustomerModel> customerModelOpt = customerJpaRepository.findById(customerId);
        if (customerModelOpt.isEmpty()) {
            throw new EntityNotFoundException("The customer with id " + customerId + " not found.");
        }
        CustomerModel customerModel = customerModelOpt.get();
        entityLogService.disabledEntity(customerModel.getEntityLogId());
        customerModel.setActif(false);
        customerJpaRepository.save(customerModel);
        return new CustomerEntity(customerModel.getId(), customerModel.getName()
                , customerModel.getOwnerId(), customerModel.getLocationId());
    }


    public List<Integer> getAllCustomersRightIdByUserId(int userId) {
        Optional<UserModel> userModelOpt = userJpaRepository.findById(userId);
        if (!userModelOpt.isPresent()) {
            throw new EntityNotFoundException("Entity user with id " + userId + " not found");
        } else {
            UserModel userModel = userModelOpt.get();
            List<CustomerModel> customersModels = userModel.getCustomers();
            return customersModels
                    .stream()
                    .map(customerModel -> customerModel.getId())
                    .toList();
        }
    }

    @Override
    public List<Integer> findAllIfHasCustomerRights(int customerId) {
        Optional<CustomerModel> customerModelOpt = customerJpaRepository.findById(customerId);
        if (!customerModelOpt.isPresent()) {
            throw new EntityNotFoundException("Entity customer with id " + customerId + " not found");
        } else {
            CustomerModel customerModel = customerModelOpt.get();
            List<Integer> userWithIdList = new ArrayList<>();
            for (UserModel user : customerModel.getUsers()) {
                userWithIdList.add(user.getUserId());
            }
            return userWithIdList;
        }
    }
}

