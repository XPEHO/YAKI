package com.xpeho.yaki_admin_backend.domain.entities.statistics;

public class PerWeekdayStatisticsEntity extends StatisticsEntity {
    String weekday;
    double declarationCount;
    double remoteCount;
    double onsiteCount;
    double vacationCount;

    public PerWeekdayStatisticsEntity() {
    }

    public PerWeekdayStatisticsEntity(String weekday, double declarationCount, double remoteCount, double onsiteCount, double vacationCount) {
        this.weekday = weekday;
        this.declarationCount = declarationCount;
        this.remoteCount = remoteCount;
        this.onsiteCount = onsiteCount;
        this.vacationCount = vacationCount;
    }

    public String getWeekday() {
        return weekday;
    }

    public void setWeekday(String weekday) {
        this.weekday = weekday;
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

    public double getVacationCount() {
        return vacationCount;
    }

    public void setVacationCount(double vacationCount) {
        this.vacationCount = vacationCount;
    }
}
