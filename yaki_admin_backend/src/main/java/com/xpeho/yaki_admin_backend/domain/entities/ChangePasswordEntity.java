package com.xpeho.yaki_admin_backend.domain.entities;

public record ChangePasswordEntity(Integer userId, String currentPassword, String newPassword) {
}
