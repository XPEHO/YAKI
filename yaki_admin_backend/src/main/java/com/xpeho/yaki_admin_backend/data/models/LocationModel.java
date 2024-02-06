package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "locations", schema = "public")
public class LocationModel {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "location_seq")
    @SequenceGenerator(name = "location_seq", sequenceName = "location_id_seq", allocationSize = 1)
    int locationId;

    @Column(name = "location_name")
    private String locationName;

    @Column(name = "location_adress")
    private String locationAdress;

    @Column(name = "location_entity_log_id")
    private int entityLogId;

    @Column(name = "location_is_active")
    private boolean actif;


    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }


    public LocationModel() {
    }

    public LocationModel(String locationName, String locationAdress, int entityLogId) {
        this.locationName = locationName;
        this.locationAdress = locationAdress;
        this.entityLogId = entityLogId;
        this.actif = true;

    }

    public int getLocationId() {
        return this.locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getLocationName() {
        return this.locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getLocationAdress() {
        return this.locationAdress;
    }

    public void setLocationAdress(String locationAdress) {
        this.locationAdress = locationAdress;
    }

    public int getEntityLogId() {
        return this.entityLogId;
    }

    public void setEntityLogId(int entityLogId) {
        this.entityLogId = entityLogId;
    }

    @Override
    public boolean equals(Object currentInstance) {
        if (this == currentInstance) return true;
        if (currentInstance == null || getClass() != currentInstance.getClass()) return false;
        LocationModel that = (LocationModel) currentInstance;
        return locationId == that.locationId &&
                entityLogId == that.entityLogId &&
                actif == that.actif &&
                Objects.equals(locationName, that.locationName) &&
                Objects.equals(locationAdress, that.locationAdress);
    }

    @Override
    public int hashCode() {
        return Objects.hash(locationId, locationName, locationAdress, entityLogId, actif);
    }

}
