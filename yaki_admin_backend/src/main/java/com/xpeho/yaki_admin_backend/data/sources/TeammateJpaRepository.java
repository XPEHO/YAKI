package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.TeammateModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TeammateJpaRepository extends JpaRepository<TeammateModel, Integer> {
    @Query("""
            SELECT tm.userId, tm.id, u.lastName, u.firstName , u.email, a.avatarReference, a.avatarBlob
            FROM TeammateModel tm 
            INNER JOIN UserModel u ON tm.userId = u.userId
            LEFT JOIN AvatarModel a ON u.userAvatarChoice = a.avatarId
            WHERE tm.teamId = ?1 and tm.actif = true
            """)
    List<Object[]> findAllByTeam(int id);
}
