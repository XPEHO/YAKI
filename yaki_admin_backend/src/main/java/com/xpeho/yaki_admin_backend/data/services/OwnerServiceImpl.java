package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.data.sources.OwnerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.services.OwnerService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OwnerServiceImpl implements OwnerService {
    OwnerJpaRepository ownerJpaRepository;

    @Override
    public List<OwnerModel> findAll() {
        return ownerJpaRepository.findAll();
    }

    @Override
    public OwnerModel save(OwnerModel entity) {
        return ownerJpaRepository.save(entity);
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
