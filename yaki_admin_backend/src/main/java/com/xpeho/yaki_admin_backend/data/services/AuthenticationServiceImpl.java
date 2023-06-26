package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.configSecurity.AuthenticationRequest;
import com.xpeho.yaki_admin_backend.configSecurity.AuthenticationResponse;
import com.xpeho.yaki_admin_backend.configSecurity.JwtService;
import com.xpeho.yaki_admin_backend.configSecurity.RegisterRequest;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
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
    public AuthenticationResponse register(RegisterRequest request) {
        UserModel user = new UserModel(
                request.getLastname(),
                request.getFirstname(),
                request.getEmail(),
                request.getLogin(),
                passwordEncoder.encode(request.getPassword()));
        repository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return new AuthenticationResponse(jwtToken);
    }

    @Override
    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getLogin(),
                        request.getPassword()
                )
        );
        UserModel user = repository.findByLogin(request.getLogin())
                .orElseThrow();
        var jwtToken = jwtService.generateToken(user);
        return new AuthenticationResponse(jwtToken);
    }
}
