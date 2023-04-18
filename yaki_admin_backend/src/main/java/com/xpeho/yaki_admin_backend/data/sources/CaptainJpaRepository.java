package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CaptainJpaRepository extends JpaRepository<CaptainModel, Integer> {
}
