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
            SELECT u
            FROM UserModel u
            WHERE u.enabled = true
            """)
    Page<UserModel> findAllEnabledUsers(Pageable pageable);

    @Query("""
            SELECT u
            FROM UserModel u
            JOIN TeammateModel tm ON u.userId = tm.userId
            JOIN TeamModel t ON tm.teamId = t.id
            WHERE u.enabled = true AND t.customerId = :customerId
            """)
    Page<UserModel> findAllEnabledUsersByCustomer(Pageable pageable, Integer customerId);

    @Query("""
            SELECT u
            FROM UserModel u
            JOIN TeammateModel tm ON u.userId = tm.userId
            LEFT JOIN CaptainModel c ON u.userId = c.userId
            JOIN TeamModel t ON tm.teamId = t.id
            WHERE u.enabled = true AND t.customerId = :customerId AND c.userId IS NULL
            """)
    Page<UserModel> findAllEnabledUsersByCustomerExcludingCaptains(Pageable pageable, Integer customerId);

    @Query("""
            SELECT u
            FROM UserModel u
            JOIN TeammateModel tm ON u.userId = tm.userId
            JOIN TeamModel t ON tm.teamId = t.id
            WHERE u.enabled = true AND t.customerId = :customerId AND t.id != :excludeTeamId
            """)
    Page<UserModel> findAllEnabledUsersByCustomerExcludingTeam(Pageable pageable, Integer customerId, Integer excludeTeamId);

    Optional<UserModel> findByLogin(String login);

    List<UserModel> findByUserIdBetween(int idStart, int idEnd);

    boolean existsByEmail(String email);
}
