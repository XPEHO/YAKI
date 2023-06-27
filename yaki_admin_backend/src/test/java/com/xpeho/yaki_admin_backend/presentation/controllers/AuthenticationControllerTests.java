package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.services.AuthenticationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class AuthenticationControllerTests {
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Mock
    private AuthenticationService authenticationService;

    @InjectMocks
    private AuthenticationController authenticationController;

    //creating mock of the controller before each test
    @BeforeEach
    public void setUp() {

    }

    //testing the authenticationController.post() register
    @Test
    void testRegister() throws Exception {
        //given
        //when
        //then

    }

    @Test
    void testAuthenticate() {
        //given
        //when
        //then

    }

}
