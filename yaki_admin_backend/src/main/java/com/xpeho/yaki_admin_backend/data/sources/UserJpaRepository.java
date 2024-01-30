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
            SELECT new com.xpeho.yaki_admin_backend.data.models.UserModel(u.userId, u.lastName, u.firstName, u.email)
            FROM UserModel u 
            WHERE u.enabled = true
            """)
    Page<UserModel> findAllEnabledUsers(Pageable pageable);

    Optional<UserModel> findByLogin(String login);

    List<UserModel> findByUserIdBetween(int idStart, int idEnd);

    boolean existsByEmail(String email);
}
