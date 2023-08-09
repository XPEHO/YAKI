package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.EntityLogModel;
import com.xpeho.yaki_admin_backend.data.sources.EntityLogJpaRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.Optional;

@Service
public class EntityLogServiceImpl {
    private final EntityLogJpaRepository entityLogJpaRepository;


    public EntityLogServiceImpl(EntityLogJpaRepository entityLogJpaRepository) {

        this.entityLogJpaRepository = entityLogJpaRepository;
    }

    //create a new Date at the current timestamp
    public EntityLogModel createEntityLog() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date(System.currentTimeMillis()));
        EntityLogModel entityLogModel = new EntityLogModel(new Date(cal.getTime().getTime()));
        return entityLogJpaRepository.save(entityLogModel);
    }
    public EntityLogModel disabledEntity(int id){
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date(System.currentTimeMillis()));
        Optional<EntityLogModel> optionalEntityLogModel = entityLogJpaRepository.findById(id);
        if(optionalEntityLogModel.isPresent()){
            EntityLogModel entityLogModel = optionalEntityLogModel.get();
            entityLogModel.setInactivationDate(new Date(cal.getTime().getTime()));
            return entityLogJpaRepository.save(entityLogModel);
        }
        throw new EntityNotFoundException("Entity Log with id " + id + " has not been found");
    }
}
