package com.xpeho.yaki_admin_backend.domain.entities;

import java.util.List;

public record UserResponseEntity(List<UserEntityWithID> users, int totalPages) {
}
