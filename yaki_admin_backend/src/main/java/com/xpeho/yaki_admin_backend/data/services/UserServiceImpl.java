package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {
    final UserJpaRepository userJpaRepository;

    public UserServiceImpl(UserJpaRepository userJpaRepository) {
        this.userJpaRepository = userJpaRepository;
    }

    public List<UserModel> findAll() {
        return userJpaRepository.findAll();
    }

    /*public UserModel save(UserEntity entity) {
        Optional<UserModel> userModel = userJpaRepository.save(entity.lastname(), entity.firstname(), entity.email(), entity.login());

    }*/

    public UserModel save(UserModel entity) {
        return userJpaRepository.save(entity);
    }

    public Optional<UserModel> findById(Integer integer) {
        return userJpaRepository.findById(integer);
    }

    public void deleteById(Integer integer) {
        userJpaRepository.deleteById(integer);
    }

    public void delete(UserModel entity) {
        userJpaRepository.delete(entity);
    }

    @Override
    public UserEntity save(String lastname, String firstname, String email, String login) {
        final UserModel userModel = new UserModel(lastname, firstname, email, login);
        final UserModel savedModel = userJpaRepository.save(userModel);
        return new UserEntity(lastname, firstname, email, login);
    }

    @Override
    public Optional<UserModel> findById(int id) {
        return userJpaRepository.findById(id);
    }
}
