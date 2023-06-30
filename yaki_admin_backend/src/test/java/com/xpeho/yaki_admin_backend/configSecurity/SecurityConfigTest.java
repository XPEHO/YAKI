package com.xpeho.yaki_admin_backend.configSecurity;

import org.junit.jupiter.api.Test;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.context.SecurityContextHolder;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

public class SecurityConfigTest {

    @Bean
    @Test
    public void testSecurityFilterChain() throws Exception {
        // Create a mock HttpSecurity object
        HttpSecurity http = mock(HttpSecurity.class);

        // Verify that the CSRF protection is disabled
        verify(http).csrf(AbstractHttpConfigurer::disable);

        // Verify that the request matchers are configured correctly
        verify(http).authorizeHttpRequests(authorize -> authorize
                .requestMatchers(
                        "/login/**",
                        "/swagger-ui/**",
                        "/swagger-resources/**",
                        "/v3/api-docs/**",
                        "/v2/api-docs",
                        "/v3/api-docs",
                        "/configuration/security",
                        "/webjars/**",
                        "/swagger-ui.html")
                .permitAll()
                .anyRequest()
                .authenticated()
        );

        // Verify that the session management is configured correctly
        verify(http).sessionManagement((sessionManagement) ->
                sessionManagement
                        .sessionConcurrency((sessionConcurrency) ->
                                sessionConcurrency
                                        .maximumSessions(1)
                                        .expiredUrl("/login?expired")
                        )
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        );


        // Verify that the logout filter is configured correctly
        verify(http).logout((logout) ->
                logout.deleteCookies("remove")
                        .invalidateHttpSession(false)
                        .logoutUrl("/login/logout")
                        .logoutSuccessUrl("/logout-success")
                        .logoutSuccessHandler((request, response, authentication) -> SecurityContextHolder.clearContext())
        );
    }
}