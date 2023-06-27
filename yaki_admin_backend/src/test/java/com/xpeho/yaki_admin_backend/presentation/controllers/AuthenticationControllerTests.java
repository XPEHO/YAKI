package com.xpeho.yaki_admin_backend.presentation.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.domain.services.AuthenticationService;
import com.xpeho.yaki_admin_backend.error_handling.CustomExceptionHandler;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.mockito.BDDMockito.given;

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
        mvc = MockMvcBuilders.standaloneSetup(authenticationController)
                .setControllerAdvice(new CustomExceptionHandler())
                .build();
    }

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
