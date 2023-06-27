package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;

public interface UserService {

    UserEntity save(UserEntityIn userEntityIn);

    UserEntity findById(int id);

    UserEntity deleteById(int id);
}
