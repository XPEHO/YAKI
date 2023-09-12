package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.ChangePasswordEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/users")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }
    @SecurityRequirement(name = "bearerAuth")
    @PostMapping
    public UserEntity createUser(@RequestBody UserEntityIn userEntity) {
        return userService.save(userEntity);
    }
    @SecurityRequirement(name = "bearerAuth")
    @GetMapping("/inRange")
    public List<UserEntityWithID> findUserByIdRange(@RequestParam int idStart,
                                                    @RequestParam int idEnd) {
        return userService.findUserByIdRange(idStart, idEnd);
    }
    @SecurityRequirement(name = "bearerAuth")
    @DeleteMapping("{id}")
    public UserEntity deleteUser(@PathVariable int id) {
        return userService.deleteById(id);
    }

    //route avalaible when changing your password
    @PutMapping("/change-password")
    public void changePassword(@RequestBody ChangePasswordEntity changePasswordEntity) {
        userService.changePassword(changePasswordEntity);
    }

}
