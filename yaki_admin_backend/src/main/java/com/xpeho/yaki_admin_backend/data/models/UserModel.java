package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;


@Inheritance(strategy= InheritanceType.JOINED)
@Table(name = "user")
@Entity
public abstract class UserModel {
    @Id
    @Column(name = "user_id")
    int id;
    @Column(name = "user_last_name")
    String lastName;
    @Column(name = "user_first_name")
    String firstName;
    @Column(name = "user_email")
    String email;
    @Column(name = "user_login")
    String login;
    @Column(name = "user_password")
    String password;

    public UserModel(int id, String lastName, String firstName, String email, String login, String password) {
        this.id = id;
        this.lastName = lastName;
        this.firstName = firstName;
        this.email = email;
        this.login = login;
        this.password = password;
    }
    public UserModel() {
    }
}
