package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.TeamModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TeamJpaRepository extends JpaRepository<TeamModel, Integer> {
    //@Query("SELECT DISTINCT team FROM TeamModel team WHERE ?1 in team.captains")
    //List<TeamModel> findAllTeamByCaptain(int id);
}
