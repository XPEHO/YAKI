package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.configSecurity.JwtService;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.models.VerificationTokenModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.*;
import com.xpeho.yaki_admin_backend.domain.services.AuthenticationService;
import com.xpeho.yaki_admin_backend.error_handling.EmailAlreadyExistsException;
import com.xpeho.yaki_admin_backend.events.OnRegistrationCompleteEvent;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {
    private final UserJpaRepository repository;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;
    private final VerificationTokenServiceImpl verificationTokenService;
    private final ApplicationEventPublisher eventPublisher;
    private final CaptainServiceImpl captainService;
    private final CustomerServiceImpl customerService;

    private final UserServiceImpl userService;

    public AuthenticationServiceImpl(UserJpaRepository repository,
                                     JwtService jwtService,
                                     AuthenticationManager authenticationManager,
                                     PasswordEncoder passwordEncoder,
                                     VerificationTokenServiceImpl verificationTokenService,
                                     ApplicationEventPublisher eventPublisher,
                                     CaptainServiceImpl captainService,
                                     CustomerServiceImpl customerService,
                                     UserServiceImpl userService) {
        this.repository = repository;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
        this.verificationTokenService = verificationTokenService;
        this.eventPublisher = eventPublisher;
        this.captainService = captainService;
        this.customerService = customerService;
        this.userService = userService;
    }

    @Override
    public RegisterResponseEntity register(RegisterRequestEntity request) {
        if (repository.existsByEmail(request.email())) {
            throw new EmailAlreadyExistsException(
                    "an account already exist with this email");
        }
        UserModel user = new UserModel(
                request.lastname(),
                request.firstname(),
                request.email(),
                request.login(),
                passwordEncoder.encode(request.password()));
        repository.save(user);
        //not sure I need it does it is used to be redirected without logging in ?
        eventPublisher.publishEvent(new OnRegistrationCompleteEvent(user));
        return new RegisterResponseEntity(user.getUserId());
    }

    @Override
    public AuthenticationResponseEntity authenticate(AuthenticationRequestEntity request) {
        try{
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            request.login(),
                            request.password()
                    )
            );
        }catch (Exception e){
            throw new BadCredentialsException("bad credentials");
        }
        UserModel user = repository.findByLogin(request.login())
                .orElseThrow();
        if(user.isEnabled() == false){
            throw new RuntimeException("you need to confirm your email before logging in");
        }
        List<Integer> captainsIdRoles = captainService.getAllCaptainsIdByUserId(user.getUserId());
        List<Integer> customersIdRoles = customerService.getAllCustomersRightIdByUserId(user.getUserId());
        var jwtToken = jwtService.generateToken(user);
        return new AuthenticationResponseEntity(jwtToken, user.getUserId(),customersIdRoles,captainsIdRoles);
    }

    @Override
    public String confirmRegister(String token) {
        VerificationTokenModel verificationToken = verificationTokenService.getVerificationToken(token);
        if(verificationToken == null){
            return "invalid token";
        }
        UserModel user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        //if the token has expired
        if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
            return "try to register again, your token has expired";
        }
        user.setEnabled(true);
        repository.save(user);
        return "Your account has been verified, you can now access to your account on the mobile application with your credential";
    }


    @Override
    public void forgotPassword(ResetPasswordEntity emailEntity) {
        Optional<UserModel> user = repository.findByLogin(emailEntity.email());
        if(!user.isPresent()){
            throw new EntityNotFoundException("no user found with this email");
        }
        try{
            userService.resetPassword(user.get(),this.passwordEncoder);
        }catch (Exception e){
            throw new RuntimeException("an error has occurred while trying to reset your password");
        }
        //send an email
    }


}
