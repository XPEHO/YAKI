package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.models.VerificationTokenModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationTokenJpaRepository extends JpaRepository<VerificationTokenModel, Integer> {
    VerificationTokenModel findByToken(String token);

    VerificationTokenModel findByUser(UserModel user);
}
