package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;

import java.util.List;
import java.util.Optional;

public interface OwnerService {

    List<OwnerEntity> findAll();

    OwnerEntity createOwner(OwnerEntity ownerEntity);

    Optional<OwnerModel> findById(Integer integer);

    void deleteById(Integer integer);
}
