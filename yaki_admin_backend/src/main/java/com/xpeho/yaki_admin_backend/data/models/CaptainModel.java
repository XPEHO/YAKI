package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "captain", schema = "public")
public class CaptainModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "captain_seq")
    @SequenceGenerator(name = "captain_seq", sequenceName = "captain_id_seq", allocationSize = 1)
    @Column(name = "captain_id")
    int captainId;

    @ManyToOne
    @JoinColumn(name = "captain_user_id", insertable = false, updatable = false)
    private UserModel user;

    @Column(name = "captain_user_id")
    private int userId;

    @Column(name = "captain_customer_id")
    private int customerId;

    public CaptainModel(int captainId, List<UserModel> users, int userId, CustomerModel customer, int customerId) {
        this.captainId = captainId;
        this.userId = userId;
        this.customerId = customerId;
    }

    public CaptainModel(int userId, int customerId) {
        this.userId = userId;
        this.customerId = customerId;
    }

    public CaptainModel() {
    }

    public CaptainModel(int captainId, int userId, int customerId) {
        this.captainId = captainId;
        this.userId = userId;
        this.customerId = customerId;
    }

    public UserModel getUser() {
        return user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getCaptainId() {
        return captainId;
    }

    public void setCaptainId(int captainId) {
        this.captainId = captainId;
    }
}
