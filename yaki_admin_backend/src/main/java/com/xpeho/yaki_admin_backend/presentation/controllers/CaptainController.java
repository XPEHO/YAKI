package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.services.CaptainService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/captains")
@CrossOrigin

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
    public void deleteById(@PathVariable Integer id) {
        captainService.deleteById(id);
    }
}
