package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import jakarta.persistence.EntityNotFoundException;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {


    final UserJpaRepository userJpaRepository;


    public UserServiceImpl(UserJpaRepository userJpaRepository) {
        this.userJpaRepository = userJpaRepository;

    }

    @Override
    public UserEntity save(UserEntityIn user) {

        BCryptPasswordEncoder bcrypt = new BCryptPasswordEncoder();
        String encodedPassword = bcrypt.encode(user.password());

        final UserModel userModel = new UserModel(
                user.id(),
                user.lastname(),
                user.firstname(),
                user.email(),
                user.login(),
                encodedPassword);
        userJpaRepository.save(userModel);
        return new UserEntity(
                user.lastname(),
                user.firstname(),
                user.email(),
                user.login());
    }


    @Override
    public UserEntity findById(int id) {

        Optional<UserModel> userModelOptional = userJpaRepository.findById(id);
        if (userModelOptional.isPresent()) {
            UserModel userModel = userModelOptional.get();
            return new UserEntity(
                    userModel.getLastName(),
                    userModel.getFirstName(),
                    userModel.getEmail(),
                    userModel.getLogin());
        } else throw new EntityNotFoundException("Entity User with id " + id + " not found");
    }
}
