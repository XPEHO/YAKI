package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;


import java.util.List;

public interface UserJpaRepository extends JpaRepository<UserModel, Integer> {

    List<UserModel> findByUserIdBetween(int idStart,int idEnd);

}
