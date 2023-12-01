package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "team", schema = "public")
public class TeamModel {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "team_seq")
    @SequenceGenerator(name = "team_seq", sequenceName = "team_id_seq", allocationSize = 1)
    @Column(name = "team_id")
    private int id;

    @ManyToMany
    @JoinTable(name = "captains_teams", joinColumns = @JoinColumn(name = "captains_teams_team_id"), inverseJoinColumns = @JoinColumn(name = "captains_teams_captain_id"))
    private List<CaptainModel> captains;

    @Column(name = "team_name")
    private String teamName;

    @Column(name = "team_actif_flag")
    private boolean actif;

    @Column(name = "team_customer_id")
    private int customerId;

    @Column(name = "team_entity_log_id")
    private int entityLogId;

    @Column(name = "team_description", nullable = true)
    private String teamDescription;


    public TeamModel(List<CaptainModel> captainsModel, String teamName, int customerId, int entityLogId, String teamDescription) {
        this.captains = captainsModel;
        this.teamName = teamName;
        this.actif = true;
        this.customerId = customerId;
        this.entityLogId = entityLogId;
        this.teamDescription = teamDescription;
    }

    public TeamModel(int id, List<CaptainModel> captainsModel, String teamName, int customerId, int entityLogId, String teamDescription) {
        this.id = id;
        this.captains = captainsModel;
        this.teamName = teamName;
        this.actif = true;
        this.customerId = customerId;
        this.entityLogId = entityLogId;
        this.teamDescription = teamDescription;
    }

    public TeamModel() {
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
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

    public List<CaptainModel> getCaptains() {
        return this.captains;
    }

    public void setCaptainId(List<CaptainModel> captains) {
        this.captains = captains;
    }

    public int getEntityLogId() {
        return entityLogId;
    }

    public void setEntityLogId(int entityLogId) {
        this.entityLogId = entityLogId;
    }

    public String getTeamDescription() {
        return teamDescription;
    }

    public void setDescription(String teamDescription) {
        this.teamDescription = teamDescription;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeamModel teamModel = (TeamModel) o;
        return id == teamModel.id && captains == teamModel.captains && Objects.equals(teamName, teamModel.teamName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, captains, teamName);
    }


}
