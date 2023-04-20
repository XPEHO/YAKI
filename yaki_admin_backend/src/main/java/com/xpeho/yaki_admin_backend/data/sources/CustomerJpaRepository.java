package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerJpaRepository extends JpaRepository<CustomerModel, Integer> {

}
