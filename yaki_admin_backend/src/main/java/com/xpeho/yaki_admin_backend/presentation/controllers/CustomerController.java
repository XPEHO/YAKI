package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerRightsEntity;
import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin
@RequestMapping("/customers")
@SecurityRequirement(name = "bearerAuth")
public class CustomerController {

    final CustomerService customerService;

    public CustomerController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @GetMapping
    public List<CustomerEntity> getCustomers() {
        return customerService.getCustomers();
    }

    @PostMapping
    public CustomerEntity createCustomer(
            @RequestBody CustomerEntity customerEntity
    ) {
        return customerService.createCustomer(customerEntity);
    }

    @PostMapping("/{customerId}/users")
    public CustomerEntity addCustomerRight(
            @RequestBody Map<String, Integer> requestBody,
            @PathVariable int customerId
    ) {
        int userId = requestBody.get("userId");
        CustomerEntity customer = customerService.findById(customerId);
        List<CustomerRightsEntity> customerRights = customer.getCustomerRights();
        for (CustomerRightsEntity customerRight : customerRights) {
            if (customerRight.getUser().getId() == userId) {
                // The user already has rights for this customer
                return customer;
            }
        }
        // The user does not yet have rights for this customer, so we add a new right
        OwnerController userService = null;
        OwnerEntity user = userService.findById(userId);
        CustomerRightsEntity customerRight = new CustomerRightsEntity(userId, customerId);
        customerRight.userId(userService.findById();
        customerRight.setCustomer(customer);
        customerRights.add(customerRight);
        customer.setCustomerRights(customerRights);
        return customerService.save(customer);
    }


    @GetMapping("{id}")
    public CustomerEntity getCustomer(@PathVariable int id) {
        return customerService.getCustomer(id);
    }

    @DeleteMapping("{id}")
    public CustomerEntity deleteCustomer(@PathVariable int id) {
        return customerService.deleteById(id);
    }

    @PutMapping("{id}")
    public CustomerEntity update(@RequestBody CustomerEntity entity, @PathVariable int id) {
        return customerService.saveOrUpdate(entity, id);
    }


}
