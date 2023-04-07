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

    private final CustomerJpaRepository customerJpaRepository;


    public CustomerServiceImpl(CustomerJpaRepository customerJpaRepository) {
        this.customerJpaRepository = customerJpaRepository;
    }


    @Override
    public List<CustomerEntity> getCustomers() {
        return customerJpaRepository
                .findAll()
                .stream()
                .map(customerModel -> new CustomerEntity(customerModel.getId(), customerModel.getName(), customerModel.getOwnerId(), customerModel.getLocationId()))
                .toList();
    }

    @Override
    public CustomerEntity createCustomer(CustomerEntity customerEntity) {
        final CustomerModel customerModel = new CustomerModel(customerEntity.customer_name(), customerEntity.owner_id(), customerEntity.location_id());
        customerJpaRepository.save(customerModel);
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
        return new CustomerEntity(captainModel.getId(), captainModel.getName(), captainModel.getOwnerId(), captainModel.getLocationId());
    }

    @Override
    public void deleteById(int id) {
        if (customerJpaRepository.existsById(id)) {
            customerJpaRepository.deleteById(id);
        }
    }

    @Override
    public CustomerEntity saveOrUpdate(CustomerEntity entity, int id) {
        Optional<CustomerModel> customerModelOpt = customerJpaRepository.findById(id);
        if (customerModelOpt.isPresent()) {
            CustomerModel customerModel = customerModelOpt.get();
            customerModel.setName(entity.customer_name());
            customerModel.setLocationId(entity.location_id());
            customerJpaRepository.save(customerModel);

        } else {
            throw new EntityNotFoundException("Entity customer with id " + id + " not found");
        }
        CustomerEntity entitySaved = new CustomerEntity(id, entity.customer_name(), entity.owner_id(), entity.location_id());

        return entitySaved;

    }

}
