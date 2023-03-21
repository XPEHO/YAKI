package com.xpeho.yaki_admin_backend.presentation.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController()
@RequestMapping("/greetings")
public class GreetingsController {

    @GetMapping
    public String getGreetings() {
        return "Hello World!";
    }

}
