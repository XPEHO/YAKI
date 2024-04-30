package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.statistics.*;
import com.xpeho.yaki_admin_backend.domain.services.StatisticsService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@CrossOrigin
@RestController
@RequestMapping("/statistics")
@SecurityRequirement(name = "bearerAuth")
public class StatisticsController {

    final StatisticsService statisticsService;

    public StatisticsController(StatisticsService statisticsService) {
        this.statisticsService = statisticsService;
    }

    @PostMapping("basic")
    public BasicStatisticsEntity getBasicStatistics(@RequestBody StatisticsRequestEntity requestEntity) {
        checkRequestEntity(requestEntity);
        return statisticsService.getBasicStatistics(requestEntity);
    }

    @PostMapping("basic/csv")
    public ResponseEntity<byte[]> getBasicStatisticsCsv(@RequestBody StatisticsRequestEntity requestEntity) {
        checkRequestEntity(requestEntity);
        BasicStatisticsEntity basicStatistics = statisticsService.getBasicStatistics(requestEntity);
        String basicStatisticsCsvContent = StatisticsCsvConverter.convertToCsvContent(basicStatistics);
        return this.toByteArray("statistics_basic.csv", basicStatisticsCsvContent);
    }

    @PostMapping("declarations/csv")
    public ResponseEntity<byte[]> getDeclarationsListCsv(@RequestBody StatisticsRequestEntity requestEntity) {
        checkRequestEntity(requestEntity);
        ArrayList<DeclarationsListEntity> declarationsList = statisticsService.getDeclarationsList(requestEntity);
        String declarationsListCsvContent = StatisticsCsvConverter.convertListToCsvContent(declarationsList);
        if (declarationsListCsvContent == null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return this.toByteArray("statistics_declarations_list.csv", declarationsListCsvContent);
    }

    @PostMapping("global")
    public GlobalStatisticsEntity getGlobalStatistics(@RequestBody StatisticsRequestEntity requestEntity) {
        checkRequestEntity(requestEntity);
        return statisticsService.getGlobalStatistics(requestEntity);
    }

    @PostMapping("global/csv")
    public ResponseEntity<byte[]> getGlobalStatisticsCsv(@RequestBody StatisticsRequestEntity requestEntity) {
        checkRequestEntity(requestEntity);
        GlobalStatisticsEntity globalStatistics = statisticsService.getGlobalStatistics(requestEntity);
        String globalStatisticsCsvContent = StatisticsCsvConverter.convertToCsvContent(globalStatistics);
        return this.toByteArray("statistics_global.csv", globalStatisticsCsvContent);
    }

    @PostMapping("per-teammate/csv")
    public ResponseEntity<byte[]> getPerTeammateStatisticsCsv(@RequestBody StatisticsRequestEntity requestEntity) {
        checkRequestEntity(requestEntity);
        ArrayList<PerTeammateStatisticsEntity> perTeammateStatistics = statisticsService
                .getPerTeammateStatistics(requestEntity);
        String perTeammateStatisticsCsvContent = StatisticsCsvConverter.convertListToCsvContent(perTeammateStatistics);
        if (perTeammateStatisticsCsvContent == null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return this.toByteArray("statistics_per_teammate.csv", perTeammateStatisticsCsvContent);
    }

    @PostMapping("per-team/csv")
    public ResponseEntity<byte[]> getPerTeamStatisticsCsv(@RequestBody StatisticsRequestEntity requestEntity) {
        checkRequestEntity(requestEntity);
        ArrayList<PerTeamStatisticsEntity> perTeamStatistics = statisticsService.getPerTeamStatistics(requestEntity);
        String perTeamStatisticsCsvContent = StatisticsCsvConverter.convertListToCsvContent(perTeamStatistics);
        if (perTeamStatisticsCsvContent == null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return this.toByteArray("statistics_per_team.csv", perTeamStatisticsCsvContent);
    }

    @PostMapping("per-weekday/csv")
    public ResponseEntity<byte[]> getPerWeekdayStatisticsCsv(@RequestBody StatisticsRequestEntity requestEntity) {
        checkRequestEntity(requestEntity);
        ArrayList<PerWeekdayStatisticsEntity> perWeekdayStatistics = statisticsService
                .getPerWeekDayStatistics(requestEntity);
        String perWeekdayStatisticsCsvContent = StatisticsCsvConverter.convertListToCsvContent(perWeekdayStatistics);
        if (perWeekdayStatisticsCsvContent == null) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return this.toByteArray("statistics_per_weekday.csv", perWeekdayStatisticsCsvContent);
    }

    /**
     * Convert a string to a byte array
     * 
     * @param filename : name of the file
     * @param content  : content of the file
     * @return ResponseEntity<byte[]>
     */
    private ResponseEntity<byte[]> toByteArray(String filename, String content) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", filename);
        byte[] csv = content.getBytes();
        return new ResponseEntity<>(csv, headers, 200);
    }

    /**
     * Check if the request entity is valid
     * 
     * @param requestEntity : StatisticsRequestEntity to check
     */
    private void checkRequestEntity(StatisticsRequestEntity requestEntity) {
        if (requestEntity.customerId() == null) {
            throw new IllegalArgumentException("customerId is required");
        }
        if (requestEntity.periodStart() == null) {
            throw new IllegalArgumentException("periodStart is required");
        }
        if (requestEntity.periodEnd() == null) {
            throw new IllegalArgumentException("periodEnd is required");
        }
    }

}
