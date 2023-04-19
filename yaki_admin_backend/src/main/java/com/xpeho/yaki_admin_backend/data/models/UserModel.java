package com.xpeho.yaki_admin_backend.data.models;


import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;


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
    @ManyToMany
    @JoinTable(name = "customer_rights",
            joinColumns = @JoinColumn(name = "customer_rights_user_id"),
            inverseJoinColumns = @JoinColumn(name = "customer_rights_customer_id"))
    private List<CustomerModel> customers = new ArrayList<>();
    public UserModel(int userId, String lastName, String firstName, String email, String login, String password, List<CustomerModel> customers) {
        this.userId = userId;
        this.lastName = lastName;
        this.firstName = firstName;
        this.email = email;
        this.login = login;
        this.password = password;
        this.customers = customers;
    }

    public UserModel() {
    }

    public UserModel(String lastName, String firstName, String email, String login) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.login = login;
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

    public List<CustomerModel> getCustomers() {
        return customers;
    }

    public void setCustomers(List<CustomerModel> customers) {
        this.customers = customers;
    }
}
