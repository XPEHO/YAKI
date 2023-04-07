package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import org.springframework.data.jpa.repository.JpaRepository;


public interface OwnerJpaRepository extends JpaRepository<OwnerModel, Integer> {

}
