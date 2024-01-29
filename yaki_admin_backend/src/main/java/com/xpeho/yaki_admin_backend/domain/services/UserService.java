package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.ChangePasswordEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;

import java.util.List;

public interface UserService {

    UserEntity save(UserEntityIn userEntityIn);

    UserEntity findById(int id);

    List<UserEntityWithID> findUserByIdRange(int idStart, int idEnd);

    List<UserEntityWithID> findAllUsers();

    UserEntity deleteById(int id);

    void changePassword(ChangePasswordEntity changePasswordEntity);
}
