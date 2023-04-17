package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

@Entity
@Table(name = "team_mate", schema = "public")
public class TeammateModel {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "team_mate_seq")
    @SequenceGenerator(name = "team_mate_seq", sequenceName = "team_mate_id_seq", allocationSize = 1)
    @Column(name = "team_mate_id")
    private int id;
    @Column(name = "team_mate_team_id")
    private int teamId;
    @Column(name = "team_mate_user_id")
    private int userId;


    public TeammateModel(int teamId, int userId) {
        this.teamId = teamId;
        this.userId = userId;
    }

    public TeammateModel() {
    }

    public TeammateModel(int id, int teamId, int userId) {
        this.id = id;
        this.teamId = teamId;
        this.userId = userId;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
