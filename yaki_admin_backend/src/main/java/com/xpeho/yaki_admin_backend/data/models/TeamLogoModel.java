package com.xpeho.yaki_admin_backend.data.models;

import com.xpeho.yaki_admin_backend.domain.entities.TeamLogoEntity;
import jakarta.persistence.*;

@Entity
@Table(name = "team_logo", schema = "public")
public class TeamLogoModel {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "team_logo_seq")
    @SequenceGenerator(name = "team_logo_seq", sequenceName = "team_logo_id_seq", allocationSize = 1)
    @Column(name = "team_logo_id")
    private int teamLogoId;

    @Column(name = "team_logo_team_id")
    private int teamLogoTeamId;

    @Column(name = "team_logo_blob")
    private byte[] teamLogoBlob;

    public TeamLogoModel() {
    }

    public TeamLogoModel(int teamLogoTeamId, byte[] teamLogoBlob) {
        this.teamLogoTeamId = teamLogoTeamId;
        this.teamLogoBlob = teamLogoBlob;
    }

    public int getTeamLogoId() {
        return this.teamLogoId;
    }

    public void setTeamLogoId(int teamLogoId) {
        this.teamLogoId = teamLogoId;
    }

    public int getTeamLogoTeamId() {
        return this.teamLogoTeamId;
    }

    public void setTeamLogoTeamId(int teamLogoTeamId) {
        this.teamLogoTeamId = teamLogoTeamId;
    }

    public byte[] getTeamLogoBlob() {
        return this.teamLogoBlob;
    }

    public void setTeamLogoBlob(byte[] teamLogoBlob) {
        this.teamLogoBlob = teamLogoBlob;
    }

    public TeamLogoEntity toEntity() {
        TeamLogoEntity entity = new TeamLogoEntity(this.teamLogoTeamId, this.teamLogoBlob);
        return entity;
    }

    @Override
    public boolean equals(Object currentInstance) {
        if (currentInstance == this)
            return true;
        if (!(currentInstance instanceof TeamLogoModel)) {
            return false;
        }
        TeamLogoModel teamLogoModel = (TeamLogoModel) currentInstance;
        return teamLogoId == teamLogoModel.teamLogoId && teamLogoTeamId == teamLogoModel.teamLogoTeamId && java.util.Arrays.equals(teamLogoBlob, teamLogoModel.teamLogoBlob);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(teamLogoId, teamLogoTeamId, teamLogoBlob);
    }
}
