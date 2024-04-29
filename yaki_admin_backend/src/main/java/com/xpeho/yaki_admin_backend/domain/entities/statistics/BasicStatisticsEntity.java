package com.xpeho.yaki_admin_backend.domain.entities.statistics;

public class BasicStatisticsEntity extends StatisticsEntity{
    int teamsCount;
    int teammatesCount;

    public BasicStatisticsEntity() {
    }

    public BasicStatisticsEntity(int teamsCount, int teammatesCount) {
        this.teamsCount = teamsCount;
        this.teammatesCount = teammatesCount;
    }

    public int getTeamsCount() {
        return teamsCount;
    }

    public void setTeamsCount(int teamsCount) {
        this.teamsCount = teamsCount;
    }

    public int getTeammatesCount() {
        return teammatesCount;
    }

    public void setTeammatesCount(int teammatesCount) {
        this.teammatesCount = teammatesCount;
    }
}
