package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.StatisticsEntity;
import com.xpeho.yaki_admin_backend.domain.services.StatisticsService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/statistics/customer")
@SecurityRequirement(name = "bearerAuth")
public class StatisticsController {

    final StatisticsService statisticsService;

    public StatisticsController(StatisticsService statisticsService) {
        this.statisticsService = statisticsService;
    }

    @GetMapping("{id}")
    public StatisticsEntity getStatisticsByCustomer(@PathVariable Integer id) {
        return statisticsService.getStatisticsByCustomer(id);
    }

    @GetMapping("{id}/csv")
    public ResponseEntity<byte[]> getStatisticsCsvByCustomer(@PathVariable Integer id) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "statistics.csv");
        byte[] csv = statisticsService.getStatisticsCsvContentByCustomer(id).getBytes();
        return new ResponseEntity<>(csv, headers, 200);
    }

}
