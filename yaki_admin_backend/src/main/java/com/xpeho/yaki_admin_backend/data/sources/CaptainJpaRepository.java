package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CaptainJpaRepository extends JpaRepository<CaptainModel, Integer> {
    List<CaptainModel> findAllByUserId(int id);
}
