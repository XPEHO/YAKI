package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import com.xpeho.yaki_admin_backend.events.OnResetPasswordCompletEvent;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    final UserJpaRepository userJpaRepository;

    final PasswordServiceImpl passwordService;

    private final ApplicationEventPublisher eventPublisher;

    private final AuthenticationServiceImpl authService;

    //lazy to avoid circular dependency
    public UserServiceImpl(UserJpaRepository userJpaRepository, PasswordServiceImpl passwordService, ApplicationEventPublisher eventPublisher,@Lazy AuthenticationServiceImpl authService) {

        this.userJpaRepository = userJpaRepository;
        this.passwordService = passwordService;
        this.eventPublisher = eventPublisher;
        this.authService = authService;
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

    @Override
    public List<UserEntityWithID> findUserByIdRange(int idStart, int idEnd) {
        List<UserModel> userList = userJpaRepository.findByUserIdBetween(idStart, idEnd);

        List<UserEntityWithID> userWithIdList = new ArrayList<>();
        for (UserModel user : userList) {
            UserEntityWithID newUserWIthId = new UserEntityWithID(
                    user.getUserId(),
                    null,
                    null,
                    user.getLastName(),
                    user.getFirstName(),
                    user.getEmail());
            userWithIdList.add(newUserWIthId);
        }
        return userWithIdList;
    }

    @Override
    public UserEntity deleteById(int id) {
        Optional<UserModel> userModelOptional = userJpaRepository.findById(id);
        if (userModelOptional.isPresent()) {
            UserModel userModel = userModelOptional.get();
            userJpaRepository.deleteById(id);
            return new UserEntity(
                    userModel.getLastName(),
                    userModel.getFirstName(),
                    userModel.getEmail(),
                    userModel.getLogin());
        } else throw new EntityNotFoundException("Entity User with id " + id + " not found");
    }

    @Override
    public String changePassword(String email, String oldPassword, String newPassword) {
        try{
            authService.authenticate(new AuthenticationRequestEntity(email, oldPassword));
        }
        catch (Exception e){
            return "Email or Old password is not correct";
        }
        Optional<UserModel> user = userJpaRepository.findByLogin(email);
        if(user.isEmpty()) return "User not found";
        BCryptPasswordEncoder bcrypt = new BCryptPasswordEncoder();
        String encodedPassword = bcrypt.encode(newPassword);
        user.get().setPassword(encodedPassword);
        userJpaRepository.save(user.get());
        return "Password changed successfully";
    }

    public void resetPassword(UserModel user) {
        BCryptPasswordEncoder bcrypt = new BCryptPasswordEncoder();
        String temporaryPassword = passwordService.generatePassword(12);
        String encodedPassword = bcrypt.encode(temporaryPassword);
        user.setPassword(encodedPassword);
        userJpaRepository.save(user);
        eventPublisher.publishEvent(new OnResetPasswordCompletEvent(user, temporaryPassword));
    }

    //I used common text from apache because Passay present a security hotspot.

}
