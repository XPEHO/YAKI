package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity;

public interface TeamService {
    TeamEntity createTeam(TeamEntity customerEntity);

    TeamEntity getTeam(int id);

    TeamEntity deleteById(int id);

    TeamEntity saveOrUpdate(TeamEntity entity, int id);
}
