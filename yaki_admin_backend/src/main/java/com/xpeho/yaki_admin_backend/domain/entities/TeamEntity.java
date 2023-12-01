package com.xpeho.yaki_admin_backend.domain.entities;

import java.util.List;

public record TeamEntity(Integer id, List<Integer> captainsId, String teamName, Integer customerId,
                         String teamDescription
) {
}
