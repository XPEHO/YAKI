package com.xpeho.yaki_admin_backend.presentation.controllers;

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
@SecurityRequirement(name = "bearerAuth")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping
    public UserEntity createUser(@RequestBody UserEntityIn userEntity) {
        return userService.save(userEntity);
    }

    @GetMapping("/inRange")
    public List<UserEntityWithID> findUserByIdRange(@RequestParam int idStart,
                                                    @RequestParam int idEnd) {
        return userService.findUserByIdRange(idStart, idEnd);
    }

    @DeleteMapping("{id}")
    public UserEntity deleteUser(@PathVariable int id) {
        return userService.deleteById(id);
    }

    //route avalaible on the change your password
    @PutMapping("/change-password")
    public void changePassword(@RequestParam int id,
                                         @RequestParam String oldPassword,
                                         @RequestParam String newPassword) {
        userService.changePassword(id, oldPassword, newPassword);
    }

}
