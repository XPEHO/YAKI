package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.TeamLogoEntity;
import com.xpeho.yaki_admin_backend.domain.services.TeamLogoService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import java.util.Optional;

@CrossOrigin
@RestController
@RequestMapping("/teams/{id}/logo")
@SecurityRequirement(name = "bearerAuth")
public class TeamLogoController {
    final TeamLogoService teamLogoService;

    public TeamLogoController(TeamLogoService teamLogoService) {
        this.teamLogoService = teamLogoService;
    }

    @GetMapping()
    public TeamLogoEntity getTeamLogoByTeamId(@PathVariable int id) {
        return teamLogoService.getTeamLogoByTeamId(id);
    }

    @PutMapping()
    public TeamLogoEntity createOrUpdateByTeamId(@PathVariable int id, @RequestParam("file") MultipartFile file) {
        try {
            byte[] bytes = file.getBytes();

            return teamLogoService.createOrUpdateByTeamId(id, bytes);
        } catch (Exception e) {
            throw new ResponseStatusException(
                    HttpStatus.INTERNAL_SERVER_ERROR, "An error occurred while creating or updating the team logo.", e);
        }
    }

    @DeleteMapping()
    public ResponseEntity<?> deleteByTeamId(@PathVariable int id) {
        Optional<TeamLogoEntity> teamLogoEntity = teamLogoService.deleteByTeamId(id);
        if (teamLogoEntity.isPresent()) {
            return new ResponseEntity<>(teamLogoEntity.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

}
