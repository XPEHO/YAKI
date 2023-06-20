package com.xpeho.yaki_admin_backend.configSecurity;

import lombok.Builder;

@Builder
public class AuthenticationRequest {
    private String password;
    private String email;

    public AuthenticationRequest(String password, String email) {
        this.password = password;
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
