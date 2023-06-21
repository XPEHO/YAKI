package com.xpeho.yaki_admin_backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
public class YakiAdminBackendApplication {
    public static void main(String[] args) {
        SpringApplication.run(YakiAdminBackendApplication.class, args);
    }
}
