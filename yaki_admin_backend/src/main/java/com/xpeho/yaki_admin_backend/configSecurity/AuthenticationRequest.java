package com.xpeho.yaki_admin_backend.configSecurity;

import lombok.Builder;

@Builder
public class AuthenticationRequest {
    private String password;
    private String login;

    public AuthenticationRequest(String password, String login) {
        this.password = password;
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }
}
