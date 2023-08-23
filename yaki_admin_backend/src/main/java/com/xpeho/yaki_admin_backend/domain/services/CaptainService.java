package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;

import java.util.List;

public interface CaptainService {

    List<CaptainEntity> getCaptains();

    CaptainEntity createCaptain(CaptainEntity captainEntity);

    CaptainEntity getCaptainById(Integer id);

    CaptainEntity deleteById(Integer id);

    CaptainEntity saveOrUpdate(CaptainEntity entity, int captainId);

    List<Integer> getAllCaptainsIdByUserId(int userId);

    List<UserEntityWithID> getAllCaptainByCustomerId(int customerId);

    CaptainEntity disabled(int id);

}
