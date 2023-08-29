package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;

import java.util.List;

public interface TeammateService {

    TeammateEntity createTeammate(TeammateEntity teammateEntity);

    TeammateEntity getTeammate(int id);

    TeammateEntity deleteById(int id);

    TeammateEntity disabled(int id);

    TeammateEntity saveOrUpdate(TeammateEntity entity, int id);

    List<UserEntityWithID> findAllByTeam(int id);
}
