package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;
import com.xpeho.yaki_admin_backend.domain.services.TeammateService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/teammates")
public class TeammateController {
    final TeammateService teammateService;

    public TeammateController(TeammateService teammateService) {

        this.teammateService = teammateService;
    }


    @PostMapping
    public TeammateEntity createTeammate(@RequestBody TeammateEntity teammateEntity) {

        return teammateService.createTeammate(teammateEntity);
    }


    @GetMapping("{id}")
    public TeammateEntity getTeammate(@PathVariable int id) {

        return teammateService.getTeammate(id);
    }

    @DeleteMapping("{id}")
    public TeammateEntity deleteTeammate(@PathVariable int id) {

        return teammateService.deleteById(id);
    }

    @PutMapping("{id}")
    private TeammateEntity update(@RequestBody TeammateEntity entity, @PathVariable int id) {
        return teammateService.saveOrUpdate(entity, id);
    }

    @GetMapping("team/{id}")
    public List<TeammateEntity> getAllWithinTeam(@PathVariable int id) {

        return teammateService.findAllByTeam(id);
    }
}
