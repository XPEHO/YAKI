package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;

import java.util.List;

public interface TeammateService {

    TeammateEntity createTeammate(TeammateEntity teammateEntity);

    TeammateEntity getTeammate(int id);

    TeammateEntity deleteById(int id);

    TeammateEntity saveOrUpdate(TeammateEntity entity, int id);

    List<TeammateEntity> findAllByTeam(int id);
}
