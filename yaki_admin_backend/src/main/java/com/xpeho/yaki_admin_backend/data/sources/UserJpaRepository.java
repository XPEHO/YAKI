package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.List;
import java.util.Optional;

public interface UserJpaRepository extends JpaRepository<UserModel, Integer> {
    Optional<UserModel> findByLogin(String login);

    List<UserModel> findByUserIdBetween(int idStart,int idEnd);


}
