package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.CaptainsTeamsModel;
import com.xpeho.yaki_admin_backend.data.models.TeamModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CaptainsTeamsJpaRepository extends JpaRepository<CaptainsTeamsModel, Integer> {
    @Query("select teamCap.teamModel from CaptainsTeamsModel teamCap where teamCap.captainModel.captainId = :idCap")
    List<TeamModel> findAllTeamsByCaptain(@Param("idCap") int id);


}
