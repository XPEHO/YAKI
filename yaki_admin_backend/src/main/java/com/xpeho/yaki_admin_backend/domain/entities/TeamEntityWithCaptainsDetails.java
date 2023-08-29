package com.xpeho.yaki_admin_backend.domain.entities;

import java.util.List;

public record TeamEntityWithCaptainsDetails(Integer id, String teamName, Integer customerId, List<CaptainEntityWithDetails> captains) {
}
