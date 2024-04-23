package com.xpeho.yaki_admin_backend.domain.entities.statistics;

public class PerTeamStatisticsEntity extends StatisticsEntity{
    String teamName;
    double declarationCount;
    double remoteCount;
    double onsiteCount;

    public PerTeamStatisticsEntity() {
    }

    public PerTeamStatisticsEntity(String teamName, double declarationCount, double remoteCount, double onsiteCount) {
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

    public double getDeclarationCount() {
        return declarationCount;
    }

    public void setDeclarationCount(double declarationCount) {
        this.declarationCount = declarationCount;
    }

    public double getRemoteCount() {
        return remoteCount;
    }

    public void setRemoteCount(double remoteCount) {
        this.remoteCount = remoteCount;
    }

    public double getOnsiteCount() {
        return onsiteCount;
    }

    public void setOnsiteCount(double onsiteCount) {
        this.onsiteCount = onsiteCount;
    }
}
