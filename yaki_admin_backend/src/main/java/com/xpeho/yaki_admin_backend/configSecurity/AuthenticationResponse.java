package com.xpeho.yaki_admin_backend.configSecurity;

import lombok.Builder;

@Builder
public class AuthenticationResponse {
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
