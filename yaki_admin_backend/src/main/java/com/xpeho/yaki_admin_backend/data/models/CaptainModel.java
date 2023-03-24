package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

@Table(name = "captain")
@Entity
@PrimaryKeyJoinColumn(name = "captain_user_id")
public class CaptainModel extends UserModel {

    @Column(name = "captain_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int captainId;

    public CaptainModel(int captainId, int userId, String lastname, String firstname, String email, String login, String password) {
        super(userId, lastname, firstname, email, login, password);
        this.captainId = captainId;
    }

    public CaptainModel() {
    }

    public int getCaptainId() {
        return captainId;
    }

    public void setCaptainId(int id) {
        this.captainId = captainId;
    }
}
