package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.sources.DeclarationJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.statistics.*;
import com.xpeho.yaki_admin_backend.data.sources.TeamJpaRepository;
import com.xpeho.yaki_admin_backend.data.sources.TeammateJpaRepository;
import com.xpeho.yaki_admin_backend.domain.services.StatisticsService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

@Service
public class StatisticsServiceImpl implements StatisticsService {
    private final TeamJpaRepository teamJpaRepository;
    private final TeammateJpaRepository teammateJpaRepository;
    private final DeclarationJpaRepository declarationJpaRepository;

    public StatisticsServiceImpl(
            TeamJpaRepository teamJpaRepository,
            TeammateJpaRepository teammateJpaRepository,
            DeclarationJpaRepository declarationJpaRepository) {
        this.teamJpaRepository = teamJpaRepository;
        this.teammateJpaRepository = teammateJpaRepository;
        this.declarationJpaRepository = declarationJpaRepository;
    }

    @Override
    public BasicStatisticsEntity getBasicStatistics(StatisticsRequestEntity requestEntity) {
        int teamsCount = teamJpaRepository.countTeamByCustomerIdAndActifIsTrue(requestEntity.customerId());
        int teammatesCount = teammateJpaRepository.countTeammateByCustomerIdAndActifIsTrue(requestEntity.customerId());
        return new BasicStatisticsEntity(teamsCount, teammatesCount);
    }

    @Override
    public ArrayList<DeclarationsListEntity> getDeclarationsList(StatisticsRequestEntity requestEntity) {
        List<Object[]> results;
        if (requestEntity.teamId() == null || requestEntity.teamId() == 0) {
            results = declarationJpaRepository.getDeclarationsListByCustomerId(requestEntity.periodStart(),
                    requestEntity.periodEnd(), requestEntity.customerId());
        } else {
            results = declarationJpaRepository.getDeclarationsListByCustomerAndTeamId(requestEntity.periodStart(),
                    requestEntity.periodEnd(), requestEntity.customerId(), requestEntity.teamId());
        }

        ArrayList<DeclarationsListEntity> declarationsListEntities = new ArrayList<>();
        for (Object[] result : results) {
            String teamName = result[0].toString();
            String firstName = result[1].toString();
            String lastName = result[2].toString();
            String declarationStatus = result[3].toString();
            LocalDateTime declarationDate = Instant.parse(result[4].toString()).atZone(ZoneId.systemDefault())
                    .toLocalDateTime();
            LocalDateTime declarationDateStart = Instant.parse(result[5].toString()).atZone(ZoneId.systemDefault())
                    .toLocalDateTime();
            LocalDateTime declarationDateEnd = Instant.parse(result[6].toString()).atZone(ZoneId.systemDefault())
                    .toLocalDateTime();

            DeclarationsListEntity declarationsListEntity = new DeclarationsListEntity(
                    teamName,
                    firstName,
                    lastName,
                    declarationStatus,
                    declarationDate,
                    declarationDateStart,
                    declarationDateEnd);
            declarationsListEntities.add(declarationsListEntity);
        }
        return declarationsListEntities;
    }

    @Override
    public GlobalStatisticsEntity getGlobalStatistics(StatisticsRequestEntity requestEntity) {
        List<Object[]> results = declarationJpaRepository.getGlobalStatisticsByCustomerId(requestEntity.periodStart(),
                requestEntity.periodEnd(), requestEntity.customerId());
        if (results.isEmpty()) {
            throw new EntityNotFoundException(
                    "The global statistics for customer with id " + requestEntity.customerId() + " not found.");
        }
        Object[] result = results.get(0);
        double declarationCount = Double.parseDouble(result[0].toString());
        double remoteCount = Double.parseDouble(result[1].toString());
        double onsiteCount = Double.parseDouble(result[2].toString());

        return new GlobalStatisticsEntity(
                declarationCount,
                remoteCount,
                onsiteCount);
    }

    @Override
    public ArrayList<PerTeammateStatisticsEntity> getPerTeammateStatistics(StatisticsRequestEntity requestEntity) {
        List<Object[]> results;
        if (requestEntity.teamId() == null || requestEntity.teamId() == 0) {
            results = declarationJpaRepository.getPerTeammateStatisticsByCustomerId(requestEntity.periodStart(),
                    requestEntity.periodEnd(), requestEntity.customerId());
        } else {
            results = declarationJpaRepository.getPerTeammateStatisticsByCustomerAndTeamId(requestEntity.periodStart(),
                    requestEntity.periodEnd(), requestEntity.customerId(), requestEntity.teamId());
        }

        ArrayList<PerTeammateStatisticsEntity> perTeammateStatisticsEntities = new ArrayList<>();
        for (Object[] result : results) {
            String firstName = result[1].toString();
            String lastName = result[2].toString();
            double declarationCount = Double.parseDouble(result[3].toString());
            double remoteCount = Double.parseDouble(result[4].toString());
            double onsiteCount = Double.parseDouble(result[5].toString());
            double absenceCount = Double.parseDouble(result[6].toString());

            PerTeammateStatisticsEntity perTeammateStatisticsEntity = new PerTeammateStatisticsEntity(
                    firstName,
                    lastName,
                    declarationCount,
                    remoteCount,
                    onsiteCount,
                    absenceCount);
            perTeammateStatisticsEntities.add(perTeammateStatisticsEntity);
        }
        return perTeammateStatisticsEntities;
    }

    @Override
    public ArrayList<PerTeamStatisticsEntity> getPerTeamStatistics(StatisticsRequestEntity requestEntity) {
        List<Object[]> results = declarationJpaRepository.getPerTeamStatisticsByCustomerId(requestEntity.periodStart(),
                requestEntity.periodEnd(), requestEntity.customerId());

        ArrayList<PerTeamStatisticsEntity> perTeamStatisticsEntities = new ArrayList<>();
        for (Object[] result : results) {
            String teamName = result[1].toString();
            double declarationCount = Double.parseDouble(result[2].toString());
            double remoteCount = Double.parseDouble(result[3].toString());
            double onsiteCount = Double.parseDouble(result[4].toString());

            PerTeamStatisticsEntity perTeamStatisticsEntity = new PerTeamStatisticsEntity(
                    teamName,
                    declarationCount,
                    remoteCount,
                    onsiteCount);
            perTeamStatisticsEntities.add(perTeamStatisticsEntity);
        }
        return perTeamStatisticsEntities;
    }

    @Override
    public ArrayList<PerWeekdayStatisticsEntity> getPerWeekDayStatistics(StatisticsRequestEntity requestEntity) {
        List<Object[]> results = declarationJpaRepository.getPerWeekDayStatisticsByCustomerId(
                requestEntity.periodStart(), requestEntity.periodEnd(), requestEntity.customerId());

        ArrayList<PerWeekdayStatisticsEntity> perWeekdayStatisticsEntities = new ArrayList<>();
        for (Object[] result : results) {
            String weekday = result[0].toString();
            double declarationCount = Double.parseDouble(result[1].toString());
            double remoteCount = Double.parseDouble(result[2].toString());
            double onsiteCount = Double.parseDouble(result[3].toString());
            double absenceCount = Double.parseDouble(result[4].toString());

            PerWeekdayStatisticsEntity perWeekdayStatisticsEntity = new PerWeekdayStatisticsEntity(
                    weekday,
                    declarationCount,
                    remoteCount,
                    onsiteCount,
                    absenceCount);
            perWeekdayStatisticsEntities.add(perWeekdayStatisticsEntity);
        }
        return perWeekdayStatisticsEntities;
    }
}