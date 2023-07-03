package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.configSecurity.AuthenticationRequest;
import com.xpeho.yaki_admin_backend.configSecurity.AuthenticationResponse;
import com.xpeho.yaki_admin_backend.configSecurity.JwtService;
import com.xpeho.yaki_admin_backend.configSecurity.RegisterRequest;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationResponseEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterRequestEntity;
import com.xpeho.yaki_admin_backend.domain.services.AuthenticationService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {
    private final UserJpaRepository repository;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;

    public AuthenticationServiceImpl(UserJpaRepository repository, JwtService jwtService, AuthenticationManager authenticationManager, PasswordEncoder passwordEncoder) {
        this.repository = repository;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public AuthenticationResponseEntity register(RegisterRequestEntity request) {
        UserModel user = new UserModel(
                request.lastname(),
                request.firstname(),
                request.email(),
                request.login(),
                passwordEncoder.encode(request.password()));
        repository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return new AuthenticationResponseEntity(jwtToken, user.getUserId());
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
        var jwtToken = jwtService.generateToken(user);
        return new AuthenticationResponseEntity(jwtToken, user.getUserId());
    }
}
