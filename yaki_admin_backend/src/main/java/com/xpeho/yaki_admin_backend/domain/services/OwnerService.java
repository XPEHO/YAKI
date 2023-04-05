package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.data.models.OwnerModel;

import java.util.List;
import java.util.Optional;

public interface OwnerService {
    List<OwnerModel> findAll();

    OwnerModel save(OwnerModel entity);

    Optional<OwnerModel> findById(Integer integer);

    void deleteById(Integer integer);
}
