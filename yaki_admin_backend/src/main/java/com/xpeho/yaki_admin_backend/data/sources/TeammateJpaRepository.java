package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.TeammateModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TeammateJpaRepository extends JpaRepository<TeammateModel, Integer> {
    @Query("SELECT tm.id, tm.teamId, tm.userId, u.firstName, u.lastName, u.email \n" +
            "FROM TeammateModel tm \n" +
            "JOIN UserModel u ON tm.userId = u.userId \n" +
            "WHERE tm.teamId = ?1")
    List<Object[]> findAllByTeam(int id);
}
