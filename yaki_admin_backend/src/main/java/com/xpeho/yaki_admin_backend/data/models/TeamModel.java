package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

@Entity
@Table(name = "team", schema = "public")
public class TeamModel {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "team_seq")
    @SequenceGenerator(name = "team_seq", sequenceName = "team_id_seq", allocationSize = 1)
    @Column(name = "team_id")
    int id;
    @Column(name = "team_captain_id")
    int captainId;
    @Column(name = "team_name")
    String teamName;

    public TeamModel(int captainId, String teamName) {
        this.captainId = captainId;
        this.teamName = teamName;
    }

    public TeamModel() {
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCaptainId() {
        return captainId;
    }

    public void setCaptainId(int captainId) {
        this.captainId = captainId;
    }

}
