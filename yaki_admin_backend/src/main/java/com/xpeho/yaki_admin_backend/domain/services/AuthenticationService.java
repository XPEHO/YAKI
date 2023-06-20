package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.configSecurity.AuthenticationRequest;
import com.xpeho.yaki_admin_backend.configSecurity.AuthenticationResponse;
import com.xpeho.yaki_admin_backend.configSecurity.RegisterRequest;

public interface AuthenticationService {

    AuthenticationResponse register(RegisterRequest request);

    AuthenticationResponse authenticate(AuthenticationRequest request);
}
