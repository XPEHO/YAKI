package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface UserJpaRepository extends JpaRepository<UserModel, Integer> {
    @Query("""
            SELECT new com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID(
                u.userId, 
                c.captainId, 
                t.teammateId, 
                u.lastName, 
                u.firstName, 
                u.email, 
                a.avatarReference, 
                a.avatarBlob)
            FROM UserModel u
            INNER JOIN CaptainModel c ON c.userId = u.userId
            INNER JOIN TeammateModel t ON t.userId = u.userId
            INNER JOIN AvatarModel a ON a.userId = u.userId
            WHERE u.enabled = true
            """)
    Page<UserModel> findAllEnabledUsers(Pageable pageable);

    Optional<UserModel> findByLogin(String login);

    List<UserModel> findByUserIdBetween(int idStart, int idEnd);

    boolean existsByEmail(String email);
}
