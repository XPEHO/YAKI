package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.TeammateModel;
import com.xpeho.yaki_admin_backend.data.sources.TeammateJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;
import com.xpeho.yaki_admin_backend.domain.services.TeammateService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TeammateServiceImpl implements TeammateService {

    final TeammateJpaRepository teammateJpaRepository;

    public TeammateServiceImpl(TeammateJpaRepository teammateJpaRepository) {

        this.teammateJpaRepository = teammateJpaRepository;
    }

    public List<TeammateEntity> findAllByTeam(int teamId) {
        List<TeammateModel> TeammateModels = teammateJpaRepository.findAllByTeam(teamId);
        List<TeammateEntity> teammateEntities = new ArrayList<>();
        for (TeammateModel teammateModel : TeammateModels) {
            TeammateEntity teammateEntity = new TeammateEntity(teammateModel.getId(), teammateModel.getTeamId(), teammateModel.getUserId());
            teammateEntities.add(teammateEntity);
        }
        return teammateEntities;
    }

    @Override
    public TeammateEntity createTeammate(TeammateEntity teammateEntity) {
        final TeammateModel teammateModel = new TeammateModel(teammateEntity.teamId(), teammateEntity.userId());
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
        if (teammateJpaRepository.existsById(id)) {
            TeammateModel teammateModel = teammateJpaRepository.findById(id).get();
            teammateJpaRepository.deleteById(id);
            return new TeammateEntity(id, teammateModel.getTeamId(), teammateModel.getUserId());
        } else throw new EntityNotFoundException("The teammate with id " + id + " not found.");
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

}

