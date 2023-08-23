package com.xpeho.yaki_admin_backend.domain.entities;

import java.util.List;

public record AuthenticationResponseEntity(String token, int id, List customerId, List captainId) {
}
