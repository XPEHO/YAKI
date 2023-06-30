package com.xpeho.yaki_admin_backend.configSecurity;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.io.IOException;

import static org.mockito.Mockito.*;

public class JwtAuthenticationFilterTest {
    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private FilterChain filterChain;

    @Mock
    private JwtService jwtService;

    @Mock
    private UserDetailsService userDetailsService;

    private JwtAuthenticationFilter filter;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
        filter = new JwtAuthenticationFilter(jwtService, userDetailsService);
    }


    @Test
    void testDoFilterInternal_NoAuthorizationHeader() throws ServletException, IOException {
        // Arrange
        when(request.getHeader("Authorization")).thenReturn(null);

        // Act
        filter.doFilterInternal(request, response, filterChain);

        // Assert
        verify(filterChain).doFilter(request, response);
    }

    @Test
    void testDoFilterInternal_AuthorizationHeaderWithoutBearer() throws ServletException, IOException {
        // Arrange
        when(request.getHeader("Authorization")).thenReturn("InvalidToken");

        // Act
        filter.doFilterInternal(request, response, filterChain);

        // Assert
        verify(filterChain).doFilter(request, response);
    }

    @Test
    void testDoFilterInternal_ValidAuthorizationHeader() throws ServletException, IOException {
        // Arrange
        String validToken = "validToken";
        when(request.getHeader("Authorization")).thenReturn("Bearer " + validToken);

        String userEmail = "user@example.com";
        UserDetails userDetails = mock(UserDetails.class);
        when(userDetailsService.loadUserByUsername(userEmail)).thenReturn(userDetails);
        when(jwtService.extractUserName(validToken)).thenReturn(userEmail);
        when(jwtService.isTokenValid(validToken, userDetails)).thenReturn(true);

        SecurityContext securityContext = mock(SecurityContext.class);
        SecurityContextHolder.setContext(securityContext);

        // Act
        filter.doFilterInternal(request, response, filterChain);

        // Assert
        verify(filterChain).doFilter(request, response);
        verify(securityContext).setAuthentication(any(UsernamePasswordAuthenticationToken.class));
    }
}