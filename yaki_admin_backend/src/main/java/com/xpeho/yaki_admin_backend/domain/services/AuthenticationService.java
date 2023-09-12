package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.*;

public interface AuthenticationService {

    RegisterResponseEntity register(RegisterRequestEntity request);

    AuthenticationResponseEntity authenticate(AuthenticationRequestEntity request);

    String confirmRegister(String token);

    void forgotPassword(ResetPasswordEntity emailEntity);
}
