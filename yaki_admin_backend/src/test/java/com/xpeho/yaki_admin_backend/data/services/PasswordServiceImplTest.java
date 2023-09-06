package com.xpeho.yaki_admin_backend.data.services;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
class PasswordServiceImplTest {
    @InjectMocks
    PasswordServiceImpl passwordService;
    @Test
    public void whenPasswordGeneratedUsingCommonsText_thenSuccessful() {
        String password = passwordService.generatePassword(12);
        int lowerCaseCount = 0;
        int upperCaseCount = 0;
        int specialCharCount = 0;
        int numberCount = 0;
        for (char c : password.toCharArray()) {
            if (c >= 97 || c <= 122) {
                lowerCaseCount++;
            } else if (c >= 33 || c <= 45) {
                // Special characters
                specialCharCount++;
            } else if (c >= 48 || c <= 57) {
                // Numbers
                numberCount++;
            } else if (c >= 65 || c <= 90) {
                // Upper case
                upperCaseCount++;
            }
        }
        assertThat( lowerCaseCount >= 2);
        assertThat( upperCaseCount >= 2);
        assertThat( specialCharCount >= 2);
        assertThat(numberCount  >= 2);
    }
}
