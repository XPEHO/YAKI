package com.xpeho.yaki_admin_backend.domain.entities.statistics;

import java.math.BigDecimal;

public class PerTeammateStatisticsEntity extends StatisticsEntity {
    String firstName;
    String lastName;
    BigDecimal declarationCount;
    BigDecimal remoteCount;
    BigDecimal onsiteCount;
    BigDecimal absenceCount;

    public PerTeammateStatisticsEntity() {
    }

    public PerTeammateStatisticsEntity(String firstName, String lastName, BigDecimal declarationCount, BigDecimal remoteCount,
                                       BigDecimal onsiteCount, BigDecimal absenceCount) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.declarationCount = declarationCount;
        this.remoteCount = remoteCount;
        this.onsiteCount = onsiteCount;
        this.absenceCount = absenceCount;
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

    public BigDecimal getAbsenceCount() {
        return absenceCount;
    }

    public void setAbsenceCount(BigDecimal absenceCount) {
        this.absenceCount = absenceCount;
    }
}
