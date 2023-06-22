package com.xpeho.yaki_admin_backend.configSecurity;

import org.springframework.beans.factory.annotation.Autowired;

public class RegisterRequest {
    @Autowired
    private String firstname;
    @Autowired
    private String lastname;
    @Autowired
    private String login;
    @Autowired
    private String email;
    @Autowired
    private String password;

    public RegisterRequest(String firstname, String lastname, String login, String email, String password) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.login = login;
        this.email = email;
        this.password = password;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
