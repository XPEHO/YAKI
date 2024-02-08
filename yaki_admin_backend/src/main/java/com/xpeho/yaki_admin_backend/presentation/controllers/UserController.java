package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
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
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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

    // Define a GET mapping for the root path. This method will be invoked when a GET request is made to the root path.
    @GetMapping()
    public ResponseEntity<Map<String, Object>> findAllUsers(
            // Request parameters for the page number and size. If not provided, they default to 0 and 10 respectively.
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        // Create a Pageable object with the provided page number and size. This is used to add pagination information to the database query.
        Pageable pageable = PageRequest.of(page, size);

        // Call the userService to get a Page of UserEntityWithID. The Page includes the data for the requested page, as well as pagination information.
        Page<UserEntityWithID> userPage = userService.findAllUsers(pageable);

        // Create a map to hold the response data.
        Map<String, Object> response = new HashMap<>();

        // Add the list of users to the response map. The getContent() method is used to get the list of UserEntityWithID from the Page.
        response.put("users", userPage.getContent());

        // Add the total number of pages to the response map. The getTotalPages() method is used to get the total number of pages from the Page.
        response.put("totalPages", userPage.getTotalPages());

        // Return the response map as the body of a ResponseEntity. The status is set to OK to indicate that the request was successful.
        return new ResponseEntity<>(response, HttpStatus.OK);
    }


    @DeleteMapping("{id}")
    public UserEntity deleteUser(@PathVariable int id) {
        return userService.deleteById(id);
    }

    //route available when changing your password
    @PutMapping("/change-password")
    public void changePassword(@RequestBody ChangePasswordEntity changePasswordEntity) {
        userService.changePassword(changePasswordEntity);
    }

    //route for to get the currently authenticated user
    @GetMapping("current-user")
    public UserEntity getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (principal instanceof UserDetails) {
            int id = ((UserModel) principal).getUserId();
            return userService.findById(id);
        } else {
            throw new RuntimeException("User not authenticated");
        }
    }
}