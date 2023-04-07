package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;

public interface UserService {

    UserEntity save(String lastname, String firstname, String email, String login);

    UserEntity findById(int id);
}
