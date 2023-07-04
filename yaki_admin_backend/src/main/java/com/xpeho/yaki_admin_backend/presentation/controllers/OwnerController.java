package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import com.xpeho.yaki_admin_backend.domain.services.OwnerService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/owners")
@CrossOrigin
@SecurityRequirement(name = "bearerAuth")
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
    public OwnerEntity createOwner(@RequestBody OwnerEntity ownerEntity) {
        return ownerService.createOwner(ownerEntity);
    }

    @GetMapping("{id}")
    public OwnerEntity findById(@PathVariable Integer id) {

        return ownerService.findById(id);
    }

    @DeleteMapping("{id}")
    public OwnerEntity deleteById(@PathVariable Integer id) {
        return ownerService.deleteById(id);

    }

    @PutMapping("{id}")
    public OwnerEntity update(@RequestBody OwnerEntity entity, @PathVariable int id) {
        return ownerService.saveOrUpdate(entity, id);
    }
}
