package com.xpeho.yaki_admin_backend.domain.entities.statistics;

import java.math.BigDecimal;

public class PerTeamStatisticsEntity extends StatisticsEntity{
    String teamName;
    BigDecimal declarationCount;
    BigDecimal remoteCount;
    BigDecimal onsiteCount;

    public PerTeamStatisticsEntity() {
    }

    public PerTeamStatisticsEntity(String teamName, BigDecimal declarationCount, BigDecimal remoteCount, BigDecimal onsiteCount) {
        this.teamName = teamName;
        this.declarationCount = declarationCount;
        this.remoteCount = remoteCount;
        this.onsiteCount = onsiteCount;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public BigDecimal getDeclarationCount() {
        return declarationCount;
    }

    public void setDeclarationCount(BigDecimal declarationCount) {
        this.declarationCount = declarationCount;
    }

    public BigDecimal getRemoteCount() {
        return remoteCount;
    }

    public void setRemoteCount(BigDecimal remoteCount) {
        this.remoteCount = remoteCount;
    }

    public BigDecimal getOnsiteCount() {
        return onsiteCount;
    }

    public void setOnsiteCount(BigDecimal onsiteCount) {
        this.onsiteCount = onsiteCount;
    }
}
