package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;

import java.util.Optional;

public interface UserService {

    UserEntity save(String lastname, String firstname, String email, String login);

    Optional<UserModel> findById(int id);
}
