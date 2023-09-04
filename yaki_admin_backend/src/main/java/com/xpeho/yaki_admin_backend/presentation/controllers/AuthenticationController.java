package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.AuthenticationResponseEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterRequestEntity;
import com.xpeho.yaki_admin_backend.domain.entities.RegisterResponseEntity;
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
    @PostMapping("/forgotPassword")
    public String forgotPassword(@RequestParam("email") String email){
        return authenticationService.forgotPassword(email);
    }
}
