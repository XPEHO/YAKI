package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.TeamLogoEntity;

import java.util.Optional;

public interface TeamLogoService {
    TeamLogoEntity getTeamLogoByTeamId(int id);
    TeamLogoEntity save(TeamLogoEntity teamLogoEntity);

    TeamLogoEntity createOrUpdateByTeamId(int id, byte[] teamLogoBlob);

    Optional<TeamLogoEntity> deleteByTeamId(int id);
}
