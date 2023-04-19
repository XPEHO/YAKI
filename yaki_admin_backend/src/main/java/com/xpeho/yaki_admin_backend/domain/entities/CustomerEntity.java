package com.xpeho.yaki_admin_backend.domain.entities;

public record CustomerEntity(Integer id, String customerName, Integer ownerId, Integer locationId) {
}
