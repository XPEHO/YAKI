package com.xpeho.yaki_admin_backend.configSecurity;

import lombok.Builder;

@Builder
public class AuthenticationResponse {
    private String token;
    private int id;
    public AuthenticationResponse(String token,int id) {

        this.token = token;
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
