package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.sources.CaptainJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.services.CaptainService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CaptainServiceImpl implements CaptainService {

    private final CaptainJpaRepository captainJpaRepository;

    public CaptainServiceImpl(CaptainJpaRepository captainJpaRepository) {
        this.captainJpaRepository = captainJpaRepository;
    }

    @Override
    public List<CaptainEntity> getCaptains() {
        return captainJpaRepository
                .findAll()
                .stream()
                .map(captainModel -> new CaptainEntity(captainModel.getCaptainId(), captainModel.getUserId(), captainModel.getCustomerId()))
                .toList();
    }

    @Override
    public CaptainEntity createCaptain(CaptainEntity captainEntity) {
        final CaptainModel captainModel = new CaptainModel(captainEntity.userId(), captainEntity.customerId());
        final CaptainModel savedCaptain = captainJpaRepository.save(captainModel);
        return new CaptainEntity(savedCaptain.getCaptainId(), savedCaptain.getUserId(), savedCaptain.getCustomerId());
    }

    @Override
    public CaptainEntity getCaptainById(Integer id) {
        Optional<CaptainModel> captainModelOptional = captainJpaRepository.findById(id);
        if (!captainModelOptional.isPresent()) {
            throw new EntityNotFoundException("The captain with id" + id + " cannot be found.");
        }
        CaptainModel captainModel = captainModelOptional.get();
        return new CaptainEntity(captainModel.getCaptainId(), captainModel.getUserId(), captainModel.getCustomerId());
    }

    @Override
    public CaptainEntity deleteById(Integer captainId) {
        final Optional<CaptainModel> captainModelOpt = captainJpaRepository.findById(captainId);
        if (captainModelOpt.isPresent()) {
            captainJpaRepository.deleteById(captainId);
            CaptainModel captainModel = captainModelOpt.get();
            return new CaptainEntity(captainModel.getCaptainId(), captainModel.getUserId()
                    , captainModel.getCustomerId());
        } else throw new EntityNotFoundException("The captain with id" + captainId + " cannot be found.");
    }

    @Override
    public CaptainEntity saveOrUpdate(CaptainEntity entity, int captainId) {
        Optional<CaptainModel> captainModelOpt = captainJpaRepository.findById(captainId);
        if (captainModelOpt.isPresent()) {
            CaptainModel captainModel = captainModelOpt.get();
            captainModel.setUserId(entity.userId());
            captainModel.setCustomerId(entity.customerId());
            captainJpaRepository.save(captainModel);
        } else {
            throw new EntityNotFoundException("Entity captain with id" + captainId + " not found");
        }
        CaptainEntity entitySaved = new CaptainEntity(captainId, entity.userId(), entity.customerId());
        return entitySaved;
    }
}
