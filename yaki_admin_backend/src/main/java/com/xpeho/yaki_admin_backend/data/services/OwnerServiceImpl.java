package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.data.sources.OwnerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import com.xpeho.yaki_admin_backend.domain.services.OwnerService;
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
            OwnerEntity ownerEntitie = new OwnerEntity(ownerModel.getId(), ownerModel.getUser_id());
            ownerEntities.add(ownerEntitie);
        }
        return ownerEntities;
    }

    @Override
    public OwnerEntity createOwner(OwnerEntity ownerEntity) {
        final OwnerModel model = new OwnerModel(ownerEntity.userId());
        final OwnerModel savedOwner = ownerJpaRepository.save(model);
        return new OwnerEntity(savedOwner.getId(), savedOwner.getUser_id());
    }

    @Override
    public Optional<OwnerModel> findById(Integer integer) {
        return ownerJpaRepository.findById(integer);
    }

    @Override
    public void deleteById(Integer integer) {
        ownerJpaRepository.deleteById(integer);
    }
}
