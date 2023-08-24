package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

@Entity
@Table(name = "captains_teams", schema = "public")
public class CaptainsTeamsModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "captains_teams_seq")
    @SequenceGenerator(name = "captains_teams_seq", sequenceName = "captains_teams_id_seq", allocationSize = 1)
    @Column(name = "captains_teams_id")
    private int id;

    public CaptainsTeamsModel(CaptainModel captainModel, TeamModel teamModel) {
        this.captainModel = captainModel;
        this.teamModel = teamModel;
    }
    public CaptainsTeamsModel(int captainId, int teamId) {
        this.captainId = captainId;
        this.teamId = teamId;
    }
    public CaptainsTeamsModel() {
    }
    @ManyToOne()
    @JoinColumn(name = "captains_teams_captain_id", insertable = false, updatable = false)
    private CaptainModel captainModel;

    @ManyToOne()
    @JoinColumn(name = "captains_teams_team_id", insertable = false, updatable = false)
    private TeamModel teamModel;

    @Column(name = "captains_teams_captain_id")
    private int captainId;

    @Column(name = "captains_teams_team_id")
    private int teamId;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public CaptainModel getCaptainModel() {
        return captainModel;
    }

    public void setCaptainModel(CaptainModel captainModel) {
        this.captainModel = captainModel;
    }

    public TeamModel getTeamModel() {
        return teamModel;
    }

    public void setTeamModel(TeamModel teamModel) {
        this.teamModel = teamModel;
    }

    public int getCaptainId() {
        return captainId;
    }

    public void setCaptainId(int captainId) {
        this.captainId = captainId;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }
}
