package com.xpeho.yaki_admin_backend.configSecurity;

import org.springframework.beans.factory.annotation.Autowired;

public class AuthenticationResponse {
    @Autowired
    private String token;

    public AuthenticationResponse(String token) {
        this.token = token;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
