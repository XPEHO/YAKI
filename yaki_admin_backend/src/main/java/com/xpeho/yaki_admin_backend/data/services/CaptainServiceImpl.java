package com.xpeho.yaki_admin_backend.data.services;


import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.sources.CaptainJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.services.CaptainService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CaptainServiceImpl implements CaptainService {

    final CaptainJpaRepository captainJpaRepository;

    public CaptainServiceImpl(CaptainJpaRepository captainJpaRepository) {
        this.captainJpaRepository = captainJpaRepository;
    }

    @Override
    public List<CaptainEntity> getCaptains() {
        return captainJpaRepository
                .findAll()
                .stream()
                .map(captainModel -> new CaptainEntity(captainModel.getCaptainId(), captainModel.getLastName(), captainModel.getFirstName(), captainModel.getEmail(), captainModel.getLogin()))
                .toList();
    }

    @Override
    public CaptainEntity getCaptain(int id) {
        List<CaptainModel> a = captainJpaRepository.findAll();
        Optional<CaptainModel> captainModelOpt = captainJpaRepository.findById(id);
        CaptainModel captainModel = captainModelOpt.get();
        return new CaptainEntity(captainModel.getCaptainId(), captainModel.getLastName(), captainModel.getFirstName(), captainModel.getEmail(), captainModel.getLogin());
    }
}
