package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;


@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "user", schema = "public")
@Entity
public abstract class UserModel {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "user_id")
    private int userId;
    @Column(name = "user_last_name")
    private String lastName;
    @Column(name = "user_first_name")
    private String firstName;
    @Column(name = "user_email")
    private String email;
    @Column(name = "user_login")
    private String login;
    @Column(name = "user_password")
    private String password;

    public UserModel(int userId, String lastName, String firstName, String email, String login, String password) {
        this.userId = userId;
        this.lastName = lastName;
        this.firstName = firstName;
        this.email = email;
        this.login = login;
        this.password = password;
    }

    public UserModel() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
