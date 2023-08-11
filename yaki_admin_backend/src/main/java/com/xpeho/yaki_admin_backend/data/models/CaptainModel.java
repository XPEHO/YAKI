package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

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

    @Column(name = "captain_actif_flag")
    private boolean actif;

    @Column(name = "captain_entity_log_id")
    private int entityLogId;

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }

    public CaptainModel(int userId, int customerId,int entityLogId) {
        this.userId = userId;
        this.customerId = customerId;
        this.actif = true;
        this.entityLogId = entityLogId;
    }

    public CaptainModel() {
    }

    public CaptainModel(int captainId, int userId, int customerId,int entityLogId) {
        this.captainId = captainId;
        this.userId = userId;
        this.customerId = customerId;
        this.actif = true;
        this.entityLogId = entityLogId;
    }

    public int getEntityLogId() {
        return entityLogId;
    }

    public void setEntityLogId(int entityLogId) {
        this.entityLogId = entityLogId;
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
