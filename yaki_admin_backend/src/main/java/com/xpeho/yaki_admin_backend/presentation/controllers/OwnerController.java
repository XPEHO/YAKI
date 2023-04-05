package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
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
    public List<OwnerModel> findAll() {
        return ownerService.findAll();
    }

    @PostMapping()
    public OwnerModel save(OwnerModel entity) {
        return ownerService.save(entity);
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
