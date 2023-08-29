package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity;
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntityWithCaptainsDetails;

import java.util.List;

public interface TeamService {
    TeamEntity createTeam(TeamEntity customerEntity);

    TeamEntity getTeam(int id);

    TeamEntity deleteById(int id);

    TeamEntity disabled(int id);

    TeamEntity saveOrUpdate(TeamEntity entity, int id);

    List<TeamEntity> findAllByCaptain(int id);

    List<TeamEntityWithCaptainsDetails> findAllTeamByCustomerId(int customerId);
}
