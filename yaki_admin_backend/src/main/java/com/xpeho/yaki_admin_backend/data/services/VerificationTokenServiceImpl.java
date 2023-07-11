package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.models.VerificationTokenModel;
import com.xpeho.yaki_admin_backend.data.sources.VerificationTokenJpaRepository;
import org.springframework.stereotype.Service;

@Service
public class VerificationTokenServiceImpl {
    private final VerificationTokenJpaRepository verificationTokenJpaRepository;

    public VerificationTokenServiceImpl(VerificationTokenJpaRepository verificationTokenJpaRepository) {
        this.verificationTokenJpaRepository = verificationTokenJpaRepository;
    }


    public VerificationTokenModel getVerificationToken(String token) {
        return verificationTokenJpaRepository.findByToken(token);
    }

    public void createVerificationToken(UserModel user, String token) {
        VerificationTokenModel myToken = new VerificationTokenModel(token, user);
        verificationTokenJpaRepository.save(myToken);
    }
}
