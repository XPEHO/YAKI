package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.services.CaptainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class CaptainController {

    final CaptainService captainService;

    @Autowired
    public CaptainController(CaptainService captainService) {
        this.captainService = captainService;
    }

    // get all captains
    @RequestMapping(value = "/captains", method = RequestMethod.GET)
    public List<CaptainEntity> getCaptains() {
        return captainService.getCaptains();
    }

    //get a captain by id
    @RequestMapping(value = "/captains/{id}", method = RequestMethod.GET)
    public CaptainEntity getCaptain(@PathVariable("id") int id) {
        return captainService.getCaptain(id);
    }
}
