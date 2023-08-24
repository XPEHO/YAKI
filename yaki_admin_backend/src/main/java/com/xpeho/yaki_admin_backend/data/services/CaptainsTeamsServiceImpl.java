package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CaptainsTeamsModel;
import com.xpeho.yaki_admin_backend.data.models.TeamModel;
import com.xpeho.yaki_admin_backend.data.sources.CaptainsTeamsJpaRepository;
import com.xpeho.yaki_admin_backend.domain.services.CaptainsTeamsService;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
@Service
public class CaptainsTeamsServiceImpl implements CaptainsTeamsService {
    private final CaptainsTeamsJpaRepository captainsTeamsJpaRepository;

    public CaptainsTeamsServiceImpl(CaptainsTeamsJpaRepository captainsTeamsJpaRepository) {
        this.captainsTeamsJpaRepository = captainsTeamsJpaRepository;
    }

    @Override
    public List<TeamModel> findAllTeamsByCaptain(int id) {
        return captainsTeamsJpaRepository.findAllTeamsByCaptain(id);

    }
    public boolean assignCaptainToTeam(int captainId, int teamId) {
        captainsTeamsJpaRepository.save(new CaptainsTeamsModel(captainId, teamId));
        return true;
    }
}
