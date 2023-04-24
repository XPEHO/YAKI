package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.TeammateModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TeammateJpaRepository extends JpaRepository<TeammateModel, Integer> {
    @Query("SELECT DISTINCT tm FROM TeammateModel tm WHERE tm.teamId = ?1")
    List<TeammateModel> findAllByTeam(int id);
}