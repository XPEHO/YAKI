package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.EntityLogModel;
import com.xpeho.yaki_admin_backend.data.models.TeammateModel;
import com.xpeho.yaki_admin_backend.data.sources.TeammateJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.TeammateService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TeammateServiceImpl implements TeammateService {

    final TeammateJpaRepository teammateJpaRepository;

    final EntityLogServiceImpl entityLogService;

    public TeammateServiceImpl(TeammateJpaRepository teammateJpaRepository, EntityLogServiceImpl entityLogService) {

        this.teammateJpaRepository = teammateJpaRepository;
        this.entityLogService = entityLogService;
    }

    public List<UserEntityWithID> findAllByTeam(int teamIdF) {
        List<Object[]> results = teammateJpaRepository.findAllByTeam(teamIdF);

        List<UserEntityWithID> userEntityWithIDList = new ArrayList<>();
        for (Object[] result : results) {
            int id = (int) result[0];
            int teammateId = (Integer) result[1];
            String lastname = result[2].toString();
            String firstname = result[3].toString();
            String email = result[4].toString();

            UserEntityWithID userEntityWithID = new UserEntityWithID(id, null,teammateId, lastname, firstname, email);
            userEntityWithIDList.add(userEntityWithID);
        }
        for(UserEntityWithID element: userEntityWithIDList) {
            System.out.println(element.lastname());
        }
        return userEntityWithIDList;
    }

    @Override
    public TeammateEntity createTeammate(TeammateEntity teammateEntity) {
        EntityLogModel entityLogModel = entityLogService.createEntityLog();
        final TeammateModel teammateModel = new TeammateModel(teammateEntity.teamId(), teammateEntity.userId()
                ,entityLogModel.getId());
        TeammateModel savedModel = teammateJpaRepository.save(teammateModel);
        //teammateEntity.id could be null, so we are using autogenerate id
        return new TeammateEntity(savedModel.getId(), savedModel.getTeamId(), savedModel.getUserId());
    }

    @Override
    public TeammateEntity getTeammate(int id) {
        Optional<TeammateModel> teammateModelOpt = teammateJpaRepository.findById(id);
        if (teammateModelOpt.isEmpty()) {
            throw new EntityNotFoundException("The teammate with id " + id + " not found.");
        }
        TeammateModel teammateModel = teammateModelOpt.get();
        return new TeammateEntity(teammateModel.getId(), teammateModel.getTeamId(), teammateModel.getUserId());
    }

    @Override
    public TeammateEntity deleteById(int id) {
        final Optional<TeammateModel> teammateModelOpt = teammateJpaRepository.findById(id);
        TeammateModel teammateModel = teammateModelOpt.orElseThrow(() -> new EntityNotFoundException("The teammate with id" + id + " is not found."));
        TeammateEntity returnedEntity = new TeammateEntity(id, teammateModel.getTeamId(), teammateModel.getUserId());
        teammateJpaRepository.deleteById(id);
        return returnedEntity;
    }


    @Override
    public TeammateEntity saveOrUpdate(TeammateEntity entity, int id) {
        Optional<TeammateModel> teammateModelOpt = teammateJpaRepository.findById(id);
        TeammateEntity entitySaved;
        if (teammateModelOpt.isPresent()) {
            TeammateModel teammateModel = teammateModelOpt.get();
            teammateModel.setTeamId(entity.teamId());
            teammateModel.setUserId(entity.userId());
            TeammateModel savedModel = teammateJpaRepository.save(teammateModel);
            entitySaved = new TeammateEntity(
                    savedModel.getId(), savedModel.getTeamId(), savedModel.getUserId());
        } else {
            throw new EntityNotFoundException("Entity team with id " + id + " not found");
        }

        //id and entity.id() could be different
        return entitySaved;
    }

    //disable the teammate but keep in log
    @Override
    public TeammateEntity disabled(int teammateId){
        Optional<TeammateModel> teammateModelOpt = teammateJpaRepository.findById(teammateId);
        if (teammateModelOpt.isEmpty()) {
            throw new EntityNotFoundException("The teammate with id " + teammateId + " not found.");
        }
        TeammateModel teammateModel = teammateModelOpt.get();
        entityLogService.disabledEntity(teammateModel.getEntityLogId());
        teammateModel.setActif(false);
        teammateJpaRepository.save(teammateModel);
        return new TeammateEntity(teammateModel.getId(),teammateModel.getTeamId(),teammateModel.getUserId());
    }
}
