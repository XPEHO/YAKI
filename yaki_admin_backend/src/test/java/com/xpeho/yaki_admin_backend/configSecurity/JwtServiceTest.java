package com.xpeho.yaki_admin_backend.configSecurity;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.core.userdetails.UserDetails;

import java.security.Key;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

@SpringBootTest
class JwtServiceTest {

    @MockBean
    private UserDetails userDetails;

    @Value("${token.signing.key}")
    private String secretKey;

    @Autowired
    private JwtService jwtService;

    @Test
    void generateToken() {
        // Arrange
        when(userDetails.getUsername()).thenReturn("chocapic");

        // Act
        String token = jwtService.generateToken(userDetails);

        // Assert
        assertNotNull(token);
        assertTrue(token.length() > 0);
        Claims claims = Jwts.parserBuilder().setSigningKey(jwtService.getSignInKey()).build().parseClaimsJws(token).getBody();
        assertEquals("chocapic", claims.getSubject());
    }

    @Test
    void isTokenValid() {
        // Arrange
        when(userDetails.getUsername()).thenReturn("chocapic");
        String token = jwtService.generateToken(userDetails);

        // Act
        boolean isValid = jwtService.isTokenValid(token, userDetails);

        // Assert
        assertTrue(isValid);
    }

    @Test
    void isTokenExpired() {
        boolean isValid;

        // Arrange
        when(userDetails.getUsername()).thenReturn("chocapic");
        String token = generateTokenWithExpiration("chocapic", new Date(System.currentTimeMillis() - 1000));

        // Act
        try {
            isValid = jwtService.isTokenValid(token, userDetails);
        } catch (io.jsonwebtoken.ExpiredJwtException exception) {
            isValid = false;
        }
        assertFalse(isValid);
    }

    private String generateTokenWithExpiration(String username, Date expiration) {
        return Jwts.builder()
                .setSubject(username)
                .setExpiration(expiration)
                .signWith(getSignInKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    private Key getSignInKey() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
