package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.EntityLogModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EntityLogJpaRepository extends JpaRepository<EntityLogModel,Integer> {
}
