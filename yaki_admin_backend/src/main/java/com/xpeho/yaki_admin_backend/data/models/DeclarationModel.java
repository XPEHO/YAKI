package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "declaration", schema = "public")
public class DeclarationModel {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "declaration_seq")
    @SequenceGenerator(name = "declaration_seq", sequenceName = "declaration_id_seq", allocationSize = 1)
    @Column(name = "declaration_id")
    private int id;

    @Column(name = "declaration_user_id")
    private int userId;

    @Column(name = "declaration_date")
    private LocalDateTime date;

    @Column(name = "declaration_date_start")
    private LocalDateTime dateStart;

    @Column(name = "declaration_date_end")
    private LocalDateTime dateEnd;

    @Column(name = "declaration_status")
    private String status;

    @Column(name = "declaration_team_id")
    private int teamId;

    @Column(name = "declaration_is_latest")
    private boolean isLatest;

    public DeclarationModel(int userId, LocalDateTime date, LocalDateTime dateStart, LocalDateTime dateEnd, String status, int teamId, boolean isLatest) {
        this.userId = userId;
        this.date = date;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
        this.status = status;
        this.teamId = teamId;
        this.isLatest = isLatest;
    }

    public DeclarationModel(int id, int userId, LocalDateTime date, LocalDateTime dateStart, LocalDateTime dateEnd, String status, int teamId, boolean isLatest) {
        this.id = id;
        this.userId = userId;
        this.date = date;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
        this.status = status;
        this.teamId = teamId;
        this.isLatest = isLatest;
    }

    public DeclarationModel() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public LocalDateTime getDateStart() {
        return dateStart;
    }

    public void setDateStart(LocalDateTime dateStart) {
        this.dateStart = dateStart;
    }

    public LocalDateTime getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(LocalDateTime dateEnd) {
        this.dateEnd = dateEnd;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public boolean isLatest() {
        return isLatest;
    }

    public void setLatest(boolean latest) {
        isLatest = latest;
    }
}
