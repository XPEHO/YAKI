package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/customers")
public class CustomerController {

    final CustomerService customerService;
    final UserService userService;

    public CustomerController(CustomerService customerService, UserService userService) {
        this.customerService = customerService;
        this.userService = userService;
    }

    // get all customers
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

    @PostMapping("{customerId}/{userIds}")
    public void addUserRight(@RequestBody int customerId, @RequestBody List<Integer> userIds) {
        /*List<UserModel> users = userIds.stream()
                .map(id -> userService.findById(id)
                        .orElseThrow(() -> new EntityNotFoundException(String.valueOf(id)))
                ).toList(); //can throw an error*/
        List<UserModel> users = new ArrayList<>();
        for (int id : userIds) {
            Optional<UserModel> usermodelOpt = userService.findById(id);
            if (usermodelOpt.isPresent()) {
                UserModel usermodel = usermodelOpt.get();
                users.add(usermodel);
            }
        }

        customerService.addCustomerRight(users, customerId);
    }
}
