package com.xpeho.yaki_admin_backend.domain.entities.statistics;

import java.math.BigDecimal;

public class GlobalStatisticsEntity extends StatisticsEntity{
    BigDecimal declarationCount;
    BigDecimal remoteCount;
    BigDecimal onsiteCount;
    BigDecimal absenceCount;

    public GlobalStatisticsEntity() {
    }

    public GlobalStatisticsEntity(BigDecimal declarationCount, BigDecimal remoteCount, BigDecimal onsiteCount, BigDecimal absenceCount) {
        this.declarationCount = declarationCount;
        this.remoteCount = remoteCount;
        this.onsiteCount = onsiteCount;
        this.absenceCount = absenceCount;
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
