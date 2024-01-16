package com.xpeho.yaki_admin_backend.data.dto;

public record UserWithDetailsDto(
        Integer id,
        Integer captainId,
        String lastName,
        String firstName,
        String email,
        String avatarReference,
        byte[] avatarBlob) {
}
