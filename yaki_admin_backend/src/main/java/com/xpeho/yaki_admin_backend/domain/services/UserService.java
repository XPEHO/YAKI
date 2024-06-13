package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.domain.entities.ChangePasswordEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface UserService {

    UserEntity save(UserEntityIn userEntityIn);

    UserEntity findById(int id);

    List<UserEntityWithID> findUserByIdRange(int idStart, int idEnd);


    Page<UserEntityWithID> findAllUsers(Pageable pageable, Integer customerId, Boolean excludeCaptains, Integer excludeTeamId);

    Page<UserModel> getUserPage(Pageable pageable, Integer customerId, Boolean excludeCaptains, Integer excludeTeamId);

    UserEntity deleteById(int id);

    void changePassword(ChangePasswordEntity changePasswordEntity);
}
