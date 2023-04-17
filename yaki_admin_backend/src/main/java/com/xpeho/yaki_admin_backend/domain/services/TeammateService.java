package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;

public interface TeammateService {

    TeammateEntity createTeammate(TeammateEntity teammateEntity);

    TeammateEntity getTeam(int id);

    TeammateEntity deleteById(int id);

    TeammateEntity saveOrUpdate(TeammateEntity entity, int id);
}
