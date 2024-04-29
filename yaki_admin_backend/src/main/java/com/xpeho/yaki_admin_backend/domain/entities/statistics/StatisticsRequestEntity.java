package com.xpeho.yaki_admin_backend.domain.entities.statistics;

import java.time.LocalDate;

public record StatisticsRequestEntity(Integer customerId, Integer teamId, LocalDate periodStart, LocalDate periodEnd) {
}
