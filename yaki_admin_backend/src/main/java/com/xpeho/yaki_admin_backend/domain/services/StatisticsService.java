package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.StatisticsEntity;
import org.springframework.http.ResponseEntity;

public interface StatisticsService {
    StatisticsEntity getStatisticsByCustomer(int id);
    String getStatisticsCsvContentByCustomer(int id);
}
