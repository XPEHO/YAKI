package com.xpeho.yaki_admin_backend.domain.entities.statistics;

public class PerTeammateStatisticsEntity extends StatisticsEntity{
    String firstName;
    String lastName;
    double declarationCount;
    double remoteCount;
    double onsiteCount;
    double vacationCount;

    public PerTeammateStatisticsEntity() {
    }

    public PerTeammateStatisticsEntity(String firstName, String lastName, double declarationCount, double remoteCount, double onsiteCount, double vacationCount) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.declarationCount = declarationCount;
        this.remoteCount = remoteCount;
        this.onsiteCount = onsiteCount;
        this.vacationCount = vacationCount;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
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
