package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerRightsEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @PostMapping("/addCustomerRights")
    public CustomerEntity addCustomerRight(@RequestBody CustomerRightsEntity entity) {
        return customerService.addCustomerRight(entity);
    }
    @PutMapping("/disabled/{id}")
    public CustomerEntity disabled(@PathVariable int id){
        return customerService.disabled(id);
    }
    @GetMapping("/usersRights/{id}")
    public List<Integer> getAllCustomersRightIdByUserId(@PathVariable int id){
        return customerService.findAllIfHasCustomerRights(id);
    }

}
