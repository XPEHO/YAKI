package com.xpeho.yaki_admin_backend.domain.entities;

public record UserEntityIn(Integer id, String lastname, String firstname, String email, String login, String password) {
}
