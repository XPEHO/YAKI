package com.xpeho.yaki_admin_backend.domain.entities;

import java.util.List;

public record CustomerRightsEntity(Integer customerId, List<Integer> userId) {
}
