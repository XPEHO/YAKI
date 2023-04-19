package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/customers")
public class CustomerController {

    final CustomerService customerService;
    final UserService userService;

    public CustomerController(CustomerService customerService, UserService userService) {
        this.customerService = customerService;
        this.userService = userService;
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


    @GetMapping("{id}")
    public CustomerEntity getCustomer(@PathVariable int id) {

        return customerService.getCustomer(id);
    }

    @DeleteMapping("{id}")
    public CustomerEntity deleteCustomer(@PathVariable int id) {

        return customerService.deleteById(id);
    }

    @PutMapping("{id}")
    private CustomerEntity update(@RequestBody CustomerEntity entity, @PathVariable int id) {
        CustomerEntity entitySaved = customerService.saveOrUpdate(entity, id);
        return entitySaved;
    }
}
