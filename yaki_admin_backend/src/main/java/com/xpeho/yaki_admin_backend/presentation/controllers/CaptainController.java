package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.services.CaptainService;
import com.xpeho.yaki_admin_backend.domain.services.CustomerService;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/captains")
@CrossOrigin

public class CaptainController {
    final CaptainService captainService;

    final UserService userService;

    final CustomerService customerService;

    public CaptainController(CaptainService captainService, UserService userService, CustomerService customerService) {
        this.captainService = captainService;
        this.userService = userService;
        this.customerService = customerService;
    }

    @GetMapping
    public List<CaptainEntity> getCaptains() {
        return captainService.getCaptains();
    }

    @PostMapping()
    public CaptainEntity createCaptain(
            @RequestBody CaptainEntity captainEntity
    ) {
        return captainService.createCaptain(captainEntity);
    }

    @GetMapping("{id}")
    public CaptainEntity getCaptainById(@PathVariable Integer id) {
        return captainService.getCaptainById(id);
    }

    @DeleteMapping("{id}")
    public CaptainEntity deleteById(@PathVariable Integer id) {
        return captainService.deleteById(id);
    }

    @PutMapping("{id}")
    private CaptainEntity update(@RequestBody CaptainEntity entity, @PathVariable int id) {
        CaptainEntity entitySaved = captainService.saveOrUpdate(entity, id);
        return entitySaved;
    }
}
