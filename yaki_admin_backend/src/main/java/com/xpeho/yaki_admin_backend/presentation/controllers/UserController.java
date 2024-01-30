package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.domain.entities.ChangePasswordEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityIn;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID;
import com.xpeho.yaki_admin_backend.domain.services.UserService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @GetMapping()
    public ResponseEntity<Map<String, Object>> findAllUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<UserEntityWithID> userPage = userService.findAllUsers(pageable);

        Map<String, Object> response = new HashMap<>();
        response.put("users", userPage.getContent());
        response.put("totalPages", userPage.getTotalPages());

        return new ResponseEntity<>(response, HttpStatus.OK);
    }


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
