package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.configSecurity.JwtService;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Arrays;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AuthenticationServiceImplTest {
    @Mock
    private AuthenticationManager authenticationManager;
    @Mock
    private UserJpaRepository repository;
    @Mock
    private JwtService jwtService;
    @Mock
    private PasswordEncoder passwordEncoder;
    @Mock
    private VerificationTokenServiceImpl verificationTokenService;
    @Mock
    private ApplicationEventPublisher eventPublisher;
    @InjectMocks
    private AuthenticationServiceImpl authenticationServiceImpl;
    @Mock
    private CaptainServiceImpl captainService;
    @Mock
    private CustomerServiceImpl customerService;
    @Mock
    private UserServiceImpl userService;

    @BeforeEach
    void setUp() {
        repository = mock(UserJpaRepository.class);

        authenticationServiceImpl = new AuthenticationServiceImpl(repository, jwtService, authenticationManager,
                passwordEncoder,verificationTokenService,eventPublisher,captainService,customerService, userService );
    }

    @Test
    void testRegister() {
        // Mock input
        RegisterRequestEntity request = new RegisterRequestEntity("Vache", "Quirit", "vachequirit", "vachequirit@example.com", "password");

        // Mock repository save
        UserModel savedUser = new UserModel("Vache", "Quirit", "vachequirit@example.com", "vachequirit", "encodedPassword");
        when(repository.save(any(UserModel.class))).thenReturn(savedUser);

        when(passwordEncoder.encode("password")).thenReturn("encodedPassword");
        // Perform the register operation
        RegisterResponseEntity response = authenticationServiceImpl.register(request);

        // Verify the response contains the expected values
        assertEquals(savedUser.getUserId(), response.id());
    }

    @Test
    void testAuthenticate() {
        // Mock input
        AuthenticationRequestEntity request = new AuthenticationRequestEntity("password", "vachequirit");

        // Mock authenticationManager.authenticate
        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class))).thenReturn(null);

        // Mock repository findByLogin
        UserModel user = new UserModel("Vache", "Quirit", "vachequirit.doe@example.com", "vachequirit", "encodedPassword");
        user.setEnabled(true); //simulate the user to verify this email
        when(repository.findByLogin(request.login())).thenReturn(Optional.of(user));

        // Mock jwtService.generateToken
        String jwtToken = "mockedJwtToken";
        when(jwtService.generateToken(user)).thenReturn(jwtToken);
        when(jwtService.generateToken(user)).thenReturn(jwtToken);
        when(captainService.getAllCaptainsIdByUserId(user.getUserId())).thenReturn(Arrays.asList(1,2));
        when(customerService.getAllCustomersRightIdByUserId(user.getUserId())).thenReturn(null);
        // Perform the authenticate operation
        AuthenticationResponseEntity response = authenticationServiceImpl.authenticate(request);

        // Verify the authenticationManager.authenticate was called with the correct parameters
        verify(authenticationManager).authenticate(argThat(authenticationToken ->
                authenticationToken.getPrincipal().equals("vachequirit")
                        && authenticationToken.getCredentials().equals("password")));
        // Verify the repository.findByLogin was called with the correct login
        verify(repository).findByLogin("vachequirit");

        // Verify the jwtService.generateToken was called with the correct user
        verify(jwtService).generateToken(user);

        // Verify the response contains the expected values
        assertEquals(jwtToken, response.token());
        assertEquals(user.getUserId(), response.id());
    }

    @Test
    void testForgotPassword() {
        // Mock input
        String email = "email1";
        UserModel userReturned = new UserModel("Vache", "Quirit", "email1", "email1", "encodedPassword");
        when(repository.findByLogin(email)).thenReturn(Optional.of(userReturned));
        doNothing().when(userService).resetPassword(userReturned,passwordEncoder);
        assertDoesNotThrow(() -> authenticationServiceImpl.forgotPassword(new ResetPasswordEntity(email)));
    }
}
