package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.CaptainService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/captains")
@CrossOrigin
@SecurityRequirement(name = "bearerAuth")
public class CaptainController {
    final CaptainService captainService;

    public CaptainController(CaptainService captainService) {
        this.captainService = captainService;
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
    public CaptainEntity update(@RequestBody CaptainEntity entity, @PathVariable int id) {
        return captainService.saveOrUpdate(entity, id);
    }

    @GetMapping("/customer/{id}")
    public List<UserEntityWithID> getAllCaptainByCustomerId(@PathVariable int id) {
        return captainService.getAllCaptainByCustomerId(id);
    }

    @PutMapping("/disabled/{id}")
    public CaptainEntity disabled(@PathVariable int id) {
        return captainService.disabled(id);
    }
}
