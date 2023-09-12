package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.*;
import com.xpeho.yaki_admin_backend.domain.services.AuthenticationService;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/login")
public class AuthenticationController {
    final AuthenticationService authenticationService;

    public AuthenticationController(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }

    @PostMapping("/register")
    public RegisterResponseEntity register(
            @RequestBody RegisterRequestEntity request
    ) {
        return authenticationService.register(request);
    }

    @PostMapping("/authenticate")
    public AuthenticationResponseEntity authenticate(
            @RequestBody AuthenticationRequestEntity request
    ) {
        return authenticationService.authenticate(request);
    }

    @GetMapping("/registerConfirm")
    public String confirmRegister(@RequestParam("token") String token) {
        return authenticationService.confirmRegister(token);
    }
    @PostMapping("/forgot-password")
    public void forgotPassword(@RequestBody ResetPasswordEntity emailEntity){
        authenticationService.forgotPassword(emailEntity);
    }
}
