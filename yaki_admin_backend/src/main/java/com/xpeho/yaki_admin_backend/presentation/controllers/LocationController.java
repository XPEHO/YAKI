package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.LocationEntity;
import com.xpeho.yaki_admin_backend.domain.services.LocationService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/locations")
@SecurityRequirement(name = "bearerAuth")
public class LocationController {
    final LocationService locationService;

    LocationController(LocationService locationService) {
        this.locationService = locationService;
    }

    @GetMapping
    public List<LocationEntity> getLocations() {
        return locationService.getLocations();
    }

    @PostMapping
    public LocationEntity createLocation(@RequestBody LocationEntity locationEntity) {
        return locationService.createLocation(locationEntity);
    }

    @GetMapping("{id}")
    public LocationEntity getLocation(@PathVariable Integer id) {
        return locationService.getLocationById(id);
    }

    @PutMapping("{id}")
    public LocationEntity updateLocation(@PathVariable Integer id, @RequestBody LocationEntity locationEntity) {
        return locationService.saveOrUpdate(id, locationEntity);
    }

    @PutMapping("/disable/{id}")
    public LocationEntity disableLocation(@PathVariable Integer id) {
        return locationService.disable(id);
    }

    @DeleteMapping("{id}")
    public LocationEntity deleteLocation(@PathVariable Integer id) {
        return locationService.deleteById(id);
    }


}
