package com.xpeho.yaki_admin_backend.data.models;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "user", schema = "public")
@Entity
public class UserModel {

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

    public UserModel(String lastName, String firstName, String email, String login) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.login = login;
    }

}
