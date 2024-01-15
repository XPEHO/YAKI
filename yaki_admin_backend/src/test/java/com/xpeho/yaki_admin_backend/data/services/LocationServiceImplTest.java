package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.EntityLogModel;
import com.xpeho.yaki_admin_backend.data.models.LocationModel;
import com.xpeho.yaki_admin_backend.data.sources.LocationRepository;
import com.xpeho.yaki_admin_backend.domain.entities.LocationEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

@SpringBootTest
public class LocationServiceImplTest {
    private final ObjectMapper objectMapper = new ObjectMapper();
    @MockBean
    private LocationRepository locationRepository;
    @Autowired
    private LocationServiceImpl locationService;
    @MockBean
    private EntityLogServiceImpl entityLogService;

    private LocationModel locationM1;
    private LocationModel locationM2;
    private LocationEntity locationE1;
    private LocationEntity locationE2;
    List<LocationModel> locations = new ArrayList<>();
    List<LocationEntity> locationEntities = new ArrayList<>();
    private EntityLogModel entityLogModel;


    @BeforeEach
    void setup() {
        entityLogModel = new EntityLogModel();
        entityLogModel.setId(1);
        locationM1 = new LocationModel("A la ferme", "24 ter rue du poulailler", entityLogModel.getId());
        locationM1.setLocationId(1);
        locationM2 = new LocationModel("La reine du bricolage", "2 rue des marteaux", entityLogModel.getId());
        locationM2.setLocationId(2);
        locationE1 = new LocationEntity(1, "A la ferme", "24 ter rue du poulailler");
        locationE2 = new LocationEntity(2, "La reine du bricolage", "2 rue des marteaux");
        locations.add(locationM1);
        locations.add(locationM2);
        locationEntities.add(locationE1);
        locationEntities.add(locationE2);
    }

    @Test
    public void getLocations() {
        // given
        when(locationRepository.findByActifTrue()).thenReturn(locations);
        // when
        List<LocationEntity> result = locationService.getLocations();
        // then
        assertEquals(locationEntities, result);

    }

    @Test
    public void createLocation() {
        LocationEntity locationEntityToSave = new LocationEntity(
                0,
                "A la ferme",
                "24 ter rue du poulailler");

        LocationModel locationModelToSave = new LocationModel(
                locationEntityToSave.locationName(),
                locationEntityToSave.locationAdress(),
                entityLogModel.getId());

        //given
        when(locationRepository.save(locationModelToSave)).thenReturn(locationM1);
        when(entityLogService.createEntityLog()).thenReturn(entityLogModel);

        //when
        LocationEntity result = locationService.createLocation(locationE1);
        //then
        assertEquals(locationE1, result);
    }

    @Test
    public void getLocationById() {
        // given
        when(locationRepository.findById(1)).thenReturn(java.util.Optional.ofNullable(locationM1));
        // when
        LocationEntity result = locationService.getLocationById(1);
        // then
        assertEquals(locationE1, result);
    }

    @Test
    public void saveOrUpdate() {
        LocationEntity locationEntityToSave = new LocationEntity(
                0,
                "A la ferme",
                "24 ter rue du poulailler");

        when(locationRepository.findById(1)).thenReturn(Optional.of(locationM1));
        when(locationRepository.save(locationM1)).thenReturn(locationM1);
        LocationEntity result = locationService.saveOrUpdate(1, locationEntityToSave);
        assertEquals(locationE1, result);

    }

    @Test
    public void disable() {
        when(locationRepository.findById(1)).thenReturn(Optional.of(locationM1));
        when(entityLogService.disabledEntity(locationM1.getEntityLogId())).thenReturn(entityLogModel);
        locationM1.setActif(false);
        when(locationRepository.save(locationM1)).thenReturn(locationM1);

        // Act
        LocationEntity result = locationService.disable(1);

        // Assert
        assertEquals(locationE1, result);
    }

}
