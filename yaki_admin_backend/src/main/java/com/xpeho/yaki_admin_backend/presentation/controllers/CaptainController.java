package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;

import com.xpeho.yaki_admin_backend.domain.services.CaptainService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/customers")
public class CaptainController {

    final CaptainService captainService;
    @Autowired
    public CaptainController(CaptainService captainService) {
        this.captainService = captainService;
    }

    // get all customers


    // get all customers
    @GetMapping
    public List<CaptainEntity> getCaptains() {
        return captainService.getCaptains();
    }
}
