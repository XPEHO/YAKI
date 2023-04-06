package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import com.xpeho.yaki_admin_backend.domain.services.OwnerService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

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
    public Optional<OwnerModel> findById(@PathVariable Integer id) {
        return ownerService.findById(id);
    }

    @DeleteMapping("{id}")
    public void deleteById(@PathVariable Integer id) {
        ownerService.deleteById(id);
    }
}
