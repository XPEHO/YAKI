package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.util.Objects;

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

    public TeamModel(int id, int captainId, String teamName) {
        this.teamName = teamName;
        this.id = id;
        this.captainId = captainId;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeamModel teamModel = (TeamModel) o;
        return id == teamModel.id && captainId == teamModel.captainId && Objects.equals(teamName, teamModel.teamName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, captainId, teamName);
    }
}
