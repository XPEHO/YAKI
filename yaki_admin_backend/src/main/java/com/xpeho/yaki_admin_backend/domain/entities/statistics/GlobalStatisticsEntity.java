package com.xpeho.yaki_admin_backend.domain.entities.statistics;

public class GlobalStatisticsEntity extends StatisticsEntity{
    double declarationCount;
    double remoteCount;
    double onsiteCount;

    public GlobalStatisticsEntity() {
    }

    public GlobalStatisticsEntity(double declarationCount, double remoteCount, double onsiteCount) {
        this.declarationCount = declarationCount;
        this.remoteCount = remoteCount;
        this.onsiteCount = onsiteCount;
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
