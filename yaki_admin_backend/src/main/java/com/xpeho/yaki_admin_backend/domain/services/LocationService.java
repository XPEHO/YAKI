package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.LocationEntity;

import java.util.List;

public interface LocationService {

    List<LocationEntity> getLocations();

    LocationEntity createLocation(LocationEntity locationEntity);

    LocationEntity getLocationById(Integer id);

    LocationEntity saveOrUpdate(int locationId, LocationEntity entity);

    LocationEntity disable(int id);

    LocationEntity deleteById(Integer id);


}
