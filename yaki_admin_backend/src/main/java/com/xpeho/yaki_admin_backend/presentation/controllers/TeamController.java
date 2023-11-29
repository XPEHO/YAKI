package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity;
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntityWithCaptainsDetails;
import com.xpeho.yaki_admin_backend.domain.services.TeamService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/teams")
@SecurityRequirement(name = "bearerAuth")
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
    public TeamEntity getTeam(@PathVariable int id) {
        return teamService.getTeam(id);
    }

    @DeleteMapping("{id}")
    public TeamEntity deleteTeam(@PathVariable int id) {
        return teamService.deleteById(id);
    }

    @PutMapping("{id}")
    public TeamEntity update(@RequestBody TeamEntity entity, @PathVariable int id) {
        return teamService.saveOrUpdate(entity, id);
    }

    @GetMapping({"captain/{id}"})
    public List<TeamEntity> getAllWithinCaptain(@PathVariable int id) {
        return teamService.findAllByCaptain(id);
    }

    @GetMapping({"customer/{id}"})
    public List<TeamEntityWithCaptainsDetails> findAllTeamByCustomerId(@PathVariable int id) {
        return teamService.findAllTeamByCustomerId(id);
    }

    @PutMapping("/disabled/{id}")
    public TeamEntity disabled(@PathVariable int id) {
        return teamService.disabled(id);
    }
}
