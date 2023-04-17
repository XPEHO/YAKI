package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity;
import com.xpeho.yaki_admin_backend.domain.services.TeamService;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("/teams")
public class TeamController {
    final TeamService teamService;

    public TeamController(TeamService teamService) {
        this.teamService = teamService;
    }

    @PostMapping
    public TeamEntity createTeam(@RequestBody TeamEntity teamEntity) {
        
        return teamService.createTeam(teamEntity);
    }


    @GetMapping("{id}")
    public TeamEntity getCaptain(@PathVariable int id) {

        return teamService.getTeam(id);
    }

    @DeleteMapping("{id}")
    public TeamEntity deleteTeam(@PathVariable int id) {
        return teamService.deleteById(id);
    }

    @PutMapping("{id}")
    private TeamEntity update(@RequestBody TeamEntity entity, @PathVariable int id) {
        TeamEntity entitySaved = teamService.saveOrUpdate(entity, id);
        return entitySaved;
    }
}
