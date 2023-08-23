package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.configSecurity.JwtService;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.models.VerificationTokenModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationResponseEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterResponseEntity;
import com.xpeho.yaki_admin_backend.domain.services.AuthenticationService;
import com.xpeho.yaki_admin_backend.error_handling.EmailAlreadyExistsException;
import com.xpeho.yaki_admin_backend.events.OnRegistrationCompleteEvent;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.List;

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

    public AuthenticationServiceImpl(UserJpaRepository repository,
                                     JwtService jwtService,
                                     AuthenticationManager authenticationManager,
                                     PasswordEncoder passwordEncoder,
                                     VerificationTokenServiceImpl verificationTokenService,
                                     ApplicationEventPublisher eventPublisher,
                                     CaptainServiceImpl captainService,
                                     CustomerServiceImpl customerService) {
        this.repository = repository;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
        this.verificationTokenService = verificationTokenService;
        this.eventPublisher = eventPublisher;
        this.captainService = captainService;
        this.customerService = customerService;
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
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.login(),
                        request.password()
                )
        );
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
            return "badUser";
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
}
