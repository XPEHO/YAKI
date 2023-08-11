package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.data.models.TeamModel;

import java.util.List;

public interface CaptainsTeamsService {
    List<TeamModel> findAllTeamsByCaptain(int id);
}
