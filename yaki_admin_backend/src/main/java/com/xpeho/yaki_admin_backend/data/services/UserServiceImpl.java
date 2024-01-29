package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.ChangePasswordEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import com.xpeho.yaki_admin_backend.events.OnResetPasswordCompletEvent;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    final UserJpaRepository userJpaRepository;

    final PasswordServiceImpl passwordService;

    private final ApplicationEventPublisher eventPublisher;

    private final AuthenticationManager authManager;

    private final PasswordEncoder passwordEncoder;

    //lazy to avoid circular dependency
    public UserServiceImpl(UserJpaRepository userJpaRepository,
                           PasswordServiceImpl passwordService,
                           ApplicationEventPublisher eventPublisher,
                           AuthenticationManager authenticationManager,
                           PasswordEncoder passwordEncoder) {
        this.userJpaRepository = userJpaRepository;
        this.passwordService = passwordService;
        this.eventPublisher = eventPublisher;
        this.authManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
    }

    //to remove use register instead
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
                    user.getEmail(),
                    null,
                    null
            );
            userWithIdList.add(newUserWIthId);
        }
        return userWithIdList;
    }

    @Override
    public Page<UserEntityWithID> findAllUsers(Pageable pageable) {
        Pageable sortedByName = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("lastName"));
        Page<UserModel> userPage = userJpaRepository.findAll(sortedByName);
        return userPage.map(user -> new UserEntityWithID(
                user.getUserId(),
                null,
                null,
                user.getLastName(),
                user.getFirstName(),
                user.getEmail(),
                null,
                null
        ));
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
    public void changePassword(ChangePasswordEntity changePasswordEntity) {
        Optional<UserModel> user = userJpaRepository.findById(changePasswordEntity.userId());
        if (user.isEmpty()) {
            //the user should not be log in as it doesn't exist, or the id received by the front is wrong
            throw new EntityNotFoundException("Your account is unknown");
        }
        try {
            authManager.authenticate(new UsernamePasswordAuthenticationToken(user.get().getLogin(), changePasswordEntity.currentPassword()));
        } catch (Exception e) {
            throw new BadCredentialsException("Wrong password");
        }
        String encodedPassword = passwordEncoder.encode(changePasswordEntity.newPassword());
        user.get().setPassword(encodedPassword);
        userJpaRepository.save(user.get());
    }


    public void resetPassword(UserModel user, PasswordEncoder passwordEncoder) {
        String temporaryPassword = passwordService.generatePassword(12);
        String encodedPassword = passwordEncoder.encode(temporaryPassword);
        user.setPassword(encodedPassword);
        userJpaRepository.save(user);
        eventPublisher.publishEvent(new OnResetPasswordCompletEvent(user, temporaryPassword));
    }
    //I used common text from apache because Passay present a security hotspot.
}
