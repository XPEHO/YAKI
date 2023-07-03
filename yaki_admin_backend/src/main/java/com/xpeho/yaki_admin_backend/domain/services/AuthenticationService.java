package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationResponseEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterRequestEntity;

public interface AuthenticationService {

    AuthenticationResponseEntity register(RegisterRequestEntity request);

    AuthenticationResponseEntity authenticate(AuthenticationRequestEntity request);
}
