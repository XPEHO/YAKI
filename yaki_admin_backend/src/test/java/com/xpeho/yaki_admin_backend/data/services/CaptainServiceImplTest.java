package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.sources.CaptainJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

@SpringBootTest
public class CaptainServiceImplTest {
    @Autowired
    private CaptainServiceImpl captainService;

    @MockBean
    private CaptainJpaRepository captainJpaRepository;

    @Test
    void getCaptainById() {
        //given
        CustomerModel customerModel = new CustomerModel("Géo trouve tout", 1, 1);
        CaptainModel captainEntity = new CaptainModel(1, 1, 2);

        //when
        when(captainJpaRepository.findById(1)).thenReturn(Optional.of(captainEntity));
        CaptainEntity captainDto = captainService.getCaptainById(1);

        //then
        assertEquals(1, (int) captainDto.id());
        assertEquals(captainDto.userId(), 1);
        assertEquals(captainDto.customerId(), 2);

    }

    
    }


}
