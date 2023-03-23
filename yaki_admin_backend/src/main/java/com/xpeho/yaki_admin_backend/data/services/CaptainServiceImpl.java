package com.xpeho.yaki_admin_backend.data.services;


import com.xpeho.yaki_admin_backend.data.sources.CaptainJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.services.CaptainService;
import org.springframework.stereotype.Service;

import java.util.List;
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
                .map(captainModel -> new CaptainEntity(captainModel.getId())).toList();
    }
}
