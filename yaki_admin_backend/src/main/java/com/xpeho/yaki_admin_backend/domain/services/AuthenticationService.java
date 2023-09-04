package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationResponseEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterResponseEntity;

public interface AuthenticationService {

    RegisterResponseEntity register(RegisterRequestEntity request);

    AuthenticationResponseEntity authenticate(AuthenticationRequestEntity request);

    String confirmRegister(String token);

    String forgotPassword(String email);
}
