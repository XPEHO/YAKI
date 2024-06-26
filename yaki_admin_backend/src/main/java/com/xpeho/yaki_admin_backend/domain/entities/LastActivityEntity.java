package com.xpeho.yaki_admin_backend.domain.entities;

import java.time.LocalDateTime;

public class LastActivityEntity {
    String teamId;
    LocalDateTime lastActivityDate;

    public LastActivityEntity() {
    }

    public LastActivityEntity(String teamId, LocalDateTime lastActivityDate) {
        this.teamId = teamId;
        this.lastActivityDate = lastActivityDate;
    }

    public String getTeamId() {
        return teamId;
    }

    public void setTeamId(String teamId) {
        this.teamId = teamId;
    }

    public LocalDateTime getLastActivityDate() {
        return lastActivityDate;
    }

    public void setLastActivityDate(LocalDateTime lastActivityDate) {
        this.lastActivityDate = lastActivityDate;
    }

}

