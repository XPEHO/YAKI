package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.LastActivityEntity;
import com.xpeho.yaki_admin_backend.domain.entities.statistics.*;

import java.util.ArrayList;
import java.util.List;

public interface StatisticsService {
    BasicStatisticsEntity getBasicStatistics(StatisticsRequestEntity requestEntity);
    ArrayList<DeclarationsListEntity> getDeclarationsList(StatisticsRequestEntity requestEntity);
    GlobalStatisticsEntity getGlobalStatistics(StatisticsRequestEntity requestEntity);
    ArrayList<PerTeammateStatisticsEntity> getPerTeammateStatistics(StatisticsRequestEntity requestEntity);
    ArrayList<PerTeamStatisticsEntity> getPerTeamStatistics(StatisticsRequestEntity requestEntity);
    ArrayList<PerWeekdayStatisticsEntity> getPerWeekDayStatistics(StatisticsRequestEntity requestEntity);
    List<LastActivityEntity> getLastTeamsActivityByCustomerId (Integer customerId);
    List<LastActivityEntity> getLastTeamActivityById (Integer teamId);
}
