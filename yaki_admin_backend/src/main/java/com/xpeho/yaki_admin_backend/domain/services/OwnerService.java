package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;

import java.util.List;

public interface OwnerService {

    List<OwnerEntity> findAll();

    OwnerEntity createOwner(OwnerEntity ownerEntity);

    OwnerEntity findById(Integer integer);

    void deleteById(Integer integer);
}
