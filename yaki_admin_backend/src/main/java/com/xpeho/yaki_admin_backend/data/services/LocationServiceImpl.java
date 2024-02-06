package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.EntityLogModel;
import com.xpeho.yaki_admin_backend.data.models.LocationModel;
import com.xpeho.yaki_admin_backend.data.sources.LocationRepository;
import com.xpeho.yaki_admin_backend.domain.entities.LocationEntity;
import com.xpeho.yaki_admin_backend.domain.services.LocationService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class LocationServiceImpl implements LocationService {

    final LocationRepository locationRepository;
    private final EntityLogServiceImpl entityLogService;

    public LocationServiceImpl(LocationRepository locationRepository, EntityLogServiceImpl entityLogService) {
        this.locationRepository = locationRepository;
        this.entityLogService = entityLogService;
    }

    @Override
    public List<LocationEntity> getLocations() {
        List<LocationModel> result = locationRepository.findByActifTrue();

        List<LocationEntity> locationEntities = new ArrayList<>();

        for (LocationModel locationModel : result) {
            if (!locationModel.isActif()) continue;
            locationEntities.add(
                    new LocationEntity(
                            locationModel.getLocationId(),
                            locationModel.getLocationName(),
                            locationModel.getLocationAdress()));
        }
        return locationEntities;
    }


    @Override
    public LocationEntity createLocation(LocationEntity locationEntity) {
        EntityLogModel entityLogModel = entityLogService.createEntityLog();
        final LocationModel locationModel = new LocationModel(
                locationEntity.locationName(),
                locationEntity.locationAdress(),
                entityLogModel.getId()
        );
        LocationModel createdLocation = locationRepository.save(locationModel);

        return new LocationEntity(
                createdLocation.getLocationId(),
                createdLocation.getLocationName(),
                createdLocation.getLocationAdress());
    }


    @Override
    public LocationEntity getLocationById(Integer id) {
        final LocationModel locationModel = locationRepository
                .findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Location" + id + "not found"));

        return new LocationEntity(
                locationModel.getLocationId(),
                locationModel.getLocationName(),
                locationModel.getLocationAdress());
    }

    @Override
    public LocationEntity saveOrUpdate(int id, LocationEntity entity) {
        Optional<LocationModel> locationModelOpt = locationRepository.findById(id);

        if (locationModelOpt.isPresent()) {
            LocationModel locationToUpdate = locationModelOpt.get();
            locationToUpdate.setLocationName(entity.locationName());
            locationToUpdate.setLocationAdress(entity.locationAdress());

            LocationModel updatedLocation = locationRepository.save(locationToUpdate);

            return new LocationEntity(
                    updatedLocation.getLocationId(),
                    updatedLocation.getLocationName(),
                    updatedLocation.getLocationAdress());
        } else {
            return this.createLocation(entity);
        }
    }

    @Override
    public LocationEntity disable(int id) {
        LocationModel locationToDisable = locationRepository
                .findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Location" + id + "not found"));

        entityLogService.disabledEntity(locationToDisable.getEntityLogId());
        locationToDisable.setActif(false);
        LocationModel locationDisabled = locationRepository.save(locationToDisable);

        return new LocationEntity(
                locationDisabled.getLocationId(),
                locationDisabled.getLocationName(),
                locationDisabled.getLocationAdress());
    }

    @Override
    public LocationEntity deleteById(Integer id) {
        LocationModel locationToDelete = locationRepository
                .findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Location" + id + "not found"));

        locationRepository.deleteById(id);

        return new LocationEntity(
                locationToDelete.getLocationId(),
                locationToDelete.getLocationName(),
                locationToDelete.getLocationAdress());
    }


}
