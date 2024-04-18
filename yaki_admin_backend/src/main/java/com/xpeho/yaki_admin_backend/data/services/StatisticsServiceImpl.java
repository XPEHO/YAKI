package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.domain.entities.StatisticsEntity;
import com.xpeho.yaki_admin_backend.data.sources.TeamJpaRepository;
import com.xpeho.yaki_admin_backend.data.sources.TeammateJpaRepository;
import com.xpeho.yaki_admin_backend.domain.services.StatisticsService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class StatisticsServiceImpl implements StatisticsService {
    private final TeamJpaRepository teamJpaRepository;
    private final TeammateJpaRepository teammateJpaRepository;

    public StatisticsServiceImpl(
            TeamJpaRepository teamJpaRepository,
            TeammateJpaRepository teammateJpaRepository) {
        this.teamJpaRepository = teamJpaRepository;
        this.teammateJpaRepository = teammateJpaRepository;
    }

    @Override
    public StatisticsEntity getStatisticsByCustomer(int id) {
        int teamCount = teamJpaRepository.countTeamByCustomerIdAndActifIsTrue(id);
        int teammateCount = teammateJpaRepository.countTeammateByCustomerIdAndActifIsTrue(id);
        return new StatisticsEntity(teamCount, teammateCount);
    }

    @Override
    public String getStatisticsCsvContentByCustomer(int id) {
        String CSV_HEADER = "Team count,Teammate count\n";
        StatisticsEntity statistics = getStatisticsByCustomer(id);
        StringBuilder csv = new StringBuilder();
        csv.append(CSV_HEADER);
        csv.append(statistics.teamsCount())
                .append(",")
                .append(statistics.teammatesCount())
                .append("\n");
        return csv.toString();
    }
}
