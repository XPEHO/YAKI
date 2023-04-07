package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import com.xpeho.yaki_admin_backend.domain.services.OwnerService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Owner")
@CrossOrigin
public class OwnerController {
    final OwnerService ownerService;

    public OwnerController(OwnerService ownerService) {
        this.ownerService = ownerService;
    }

    @GetMapping
    public List<OwnerEntity> findAll() {
        return ownerService.findAll();
    }

    @PostMapping()
    public OwnerEntity createOwner(
            @RequestBody OwnerEntity ownerEntity
    ) {
        return ownerService.createOwner(ownerEntity);
    }

    @GetMapping("{id}")
    public OwnerEntity findById(@PathVariable Integer id) {
        return ownerService.findById(id);
    }

    @DeleteMapping("{id}")
    public void deleteById(@PathVariable Integer id) {
        ownerService.deleteById(id);
    }
}
