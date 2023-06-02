package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.UserEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.BDDMockito.given;

@SpringBootTest
class UserServiceImplTest {
    private final ObjectMapper objectMapper = new ObjectMapper();
    private UserModel user1;
    private UserEntity userE1;
    private UserModel user2;
    @Autowired
    private UserServiceImpl userService;

    @MockBean
    private UserJpaRepository userJpaRepository;

    @BeforeEach
    void setup() {
        userE1 = new UserEntity("Beaumont", "Bertrand", "bertrand.beaumont@mail.com", "bertrand");
        user1 = new UserModel(1, "Beaumont", "Bertrand", "bertrand.beaumont@mail.com", "bertrand", "passwordHArd");
        user2 = new UserModel("Balthazar", "Brigangnier", "Balthazar.Brigangnier@mail.com", "babri");
    }

    @Test
    void findByIdTest() throws Exception {
        //given
        given(userJpaRepository.findById(1)).willReturn(Optional.of(user1));

        //when
        UserEntity userDto = userService.findById(1);

        //then
        String returnedResponse = objectMapper.writeValueAsString(userDto);
        String expectedResponse = objectMapper.writeValueAsString(userE1);
        assertEquals(returnedResponse,
                expectedResponse);
    }

}
