package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.data.sources.OwnerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import com.xpeho.yaki_admin_backend.domain.services.OwnerService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class OwnerServiceImpl implements OwnerService {

    OwnerJpaRepository ownerJpaRepository;

    public OwnerServiceImpl(OwnerJpaRepository ownerJpaRepository) {
        this.ownerJpaRepository = ownerJpaRepository;
    }

    @Override
    public List<OwnerEntity> findAll() {
        List<OwnerModel> ownerModels = ownerJpaRepository.findAll();
        List<OwnerEntity> ownerEntities = new ArrayList<>();
        for (OwnerModel ownerModel : ownerModels) {
            OwnerEntity ownerEntity = new OwnerEntity(ownerModel.getId(), ownerModel.getUserId());
            ownerEntities.add(ownerEntity);
        }
        return ownerEntities;
    }

    @Override
    public OwnerEntity createOwner(OwnerEntity ownerEntity) {
        final OwnerModel model = new OwnerModel(ownerEntity.userId());
        final OwnerModel savedOwner = ownerJpaRepository.save(model);
        return new OwnerEntity(savedOwner.getId(), savedOwner.getUserId());
    }

    @Override
    public OwnerEntity findById(Integer id) {
        final Optional<OwnerModel> ownerModelOptional = ownerJpaRepository.findById(id);
        if (ownerModelOptional.isPresent()) {
            OwnerModel ownerModel = ownerModelOptional.get();
            return new OwnerEntity(ownerModel.getId(), ownerModel.getUserId());
        } else throw new EntityNotFoundException("Entity Owner with id " + id + " has not been found");

    }

    @Override
    public OwnerEntity deleteById(Integer id) {
        final Optional<OwnerModel> ownerModelOptional = ownerJpaRepository.findById(id);
        if (ownerModelOptional.isPresent()) {
            OwnerModel ownerModel = ownerModelOptional.get();
            ownerJpaRepository.deleteById(id);
            return new OwnerEntity(ownerModel.getId(), ownerModel.getUserId());
        } else throw new EntityNotFoundException("Entity Owner with id " + id + " has not been found");
    }

    @Override
    public OwnerEntity saveOrUpdate(OwnerEntity entity, int id) {
        Optional<OwnerModel> ownerModelOptional = ownerJpaRepository.findById(id);
        if (ownerModelOptional.isPresent()) {
            OwnerModel ownerModel = ownerModelOptional.get();
            ownerModel.setUserId(entity.userId());
            ownerJpaRepository.save(ownerModel);
        } else {
            throw new EntityNotFoundException("Entity owner with id" + id + " not found");
        }
        return new OwnerEntity(id, entity.userId());
    }
    
}
