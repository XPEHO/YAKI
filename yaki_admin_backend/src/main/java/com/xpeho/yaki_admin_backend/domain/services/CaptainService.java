package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.entities.CustomerEntity;

import java.util.List;

public interface CaptainService {
    List<CaptainEntity> getCaptains();

}
