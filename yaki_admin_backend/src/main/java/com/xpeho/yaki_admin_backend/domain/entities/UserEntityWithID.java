package com.xpeho.yaki_admin_backend.domain.entities;

public record UserEntityWithID(
        Integer id,
        Integer captainId,
        Integer teammateId,
        String lastname,
        String firstname,
        String email,
        String avatarReference,
        byte[] avatarBlob) {
}
