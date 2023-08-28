package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CustomerJpaRepository extends JpaRepository<CustomerModel, Integer> {
}
