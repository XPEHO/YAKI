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

    public CaptainsTeamsModel() {
    }
    @ManyToOne()
    @JoinColumn(name = "captains_teams_captain_id", insertable = false, updatable = false)
    private CaptainModel captainModel;

    @ManyToOne()
    @JoinColumn(name = "captains_teams_team_id", insertable = false, updatable = false)
    private TeamModel teamModel;

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
}
