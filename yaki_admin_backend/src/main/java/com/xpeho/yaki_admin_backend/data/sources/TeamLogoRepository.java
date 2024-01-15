package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.TeamLogoModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TeamLogoRepository extends JpaRepository<TeamLogoModel, Integer> {
    Optional<TeamLogoModel> findOptionalByTeamLogoTeamId(int id);
    TeamLogoModel findByTeamLogoTeamId(int id);
}
